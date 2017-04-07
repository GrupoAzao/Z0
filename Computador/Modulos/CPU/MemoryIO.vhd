library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryIO is
   PORT(
        -- Sistema
        CLK : IN  STD_LOGIC;
        RST : IN  STD_LOGIC; 
		  
		  -- RAM 16K
		ADDRESS		: IN STD_LOGIC_VECTOR (14 DOWNTO 0);
		INPUT		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		LOAD		: IN STD_LOGIC ;
		OUTPUT		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		  
        -- LCD EXTERNAL I/OS
        LCD_CS_N     : OUT   STD_LOGIC;	
        LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
        LCD_RD_N     : OUT   STD_LOGIC;	
        LCD_RESET_N  : OUT   STD_LOGIC;	
        LCD_RS       : OUT   STD_LOGIC;	-- (DCx) 0 : reg, 1: command
        LCD_WR_N     : OUT   STD_LOGIC;	

		  -- Teclado
		key_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
		key_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
        key_code     : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); --code received from PS/2
		key_new      : OUT STD_LOGIC;                     --output flag indicating new ASCII value

		  -- Signals to/from the SDRAM chip
        DRAM_ADDR     : OUT   STD_LOGIC_VECTOR (12 downto 0);
        DRAM_BA       : OUT   STD_LOGIC_VECTOR (1 downto 0);
        DRAM_CAS_N    : OUT   STD_LOGIC;
        DRAM_CKE      : OUT   STD_LOGIC;
        DRAM_CLK      : OUT   STD_LOGIC;
        DRAM_CS_N     : OUT   STD_LOGIC;
        DRAM_DQ       : INOUT STD_LOGIC_VECTOR(15 downto 0);
        DRAM_DQM      : OUT   STD_LOGIC_VECTOR(1 downto 0);
        DRAM_RAS_N    : OUT   STD_LOGIC;
        DRAM_WE_N     : OUT   STD_LOGIC
		  );
end entity;


ARCHITECTURE logic OF MemoryIO IS

component ps2_keyboard_to_ascii IS
  PORT(
      clk        : IN  STD_LOGIC;                     --system clock input
      ps2_clk    : IN  STD_LOGIC;                     --clock signal from PS2 keyboard
      ps2_data   : IN  STD_LOGIC;                     --data signal from PS2 keyboard
      ascii_new  : OUT STD_LOGIC;                     --output flag indicating new ASCII value
      ascii_code : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)); --ASCII value
END component;

component Screen is
   PORT(
	     --Display
		INPUT : IN STD_LOGIC_VECTOR(15 downto 0);
		LOAD : IN  STD_LOGIC;
		ADDRESS : IN STD_LOGIC_VECTOR(13 downto 0);
        -- Sistema
        CLK : IN  STD_LOGIC;
        RST : IN  STD_LOGIC;    
        -- LCD EXTERNAL I/OS
        LCD_CS_N     : OUT   STD_LOGIC;	
        LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
        LCD_RD_N     : OUT   STD_LOGIC;	
        LCD_RESET_N  : OUT   STD_LOGIC;	
        LCD_RS       : OUT   STD_LOGIC;	-- (DCx) 0 : reg, 1: command
        LCD_WR_N     : OUT   STD_LOGIC		
       );
end component;

component RAM16K IS
	PORT
	(
		address	    : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		    : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end component;

component PLL IS
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0				: OUT STD_LOGIC ;
		c1				: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
END component;

component Mux4Way16 is
    Port ( sel : in  STD_LOGIC_VECTOR (1 downto 0); 
        a   : in  STD_LOGIC_VECTOR (15 downto 0);   
		b   : in  STD_LOGIC_VECTOR (15 downto 0);   
		c   : in  STD_LOGIC_VECTOR (15 downto 0);   
		d   : in  STD_LOGIC_VECTOR (15 downto 0);   
        q   : out STD_LOGIC_VECTOR (15 downto 0));  
end component;

SIGNAL LOAD_RAM          : STD_LOGIC := '0';
SIGNAL LOAD_DISPLAY      : STD_LOGIC := '0';
SIGNAL CLK_1MKHZ     : STD_LOGIC;
SIGNAL OUTPUT_RAM         : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL OUTPUT_DISPLAY         : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL MUX_SEL         : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL MUX_SEL1     : STD_LOGIC;
SIGNAL MUX_SEL2     : STD_LOGIC;
SIGNAL KEY         : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL s_key_code     :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL s_key_new      :  STD_LOGIC;

BEGIN

TECLADO: ps2_keyboard_to_ascii  port map (
    clk          	=> CLK, 
    ps2_clk      	=> key_clk,
    ps2_data     	=> key_data,
	ascii_new 		=> s_key_new,
    ascii_code 	    => s_key_code
	 );

DISPLAY: Screen  port map (
         INPUT       => INPUT,
			LOAD        => LOAD_DISPLAY,
			ADDRESS		=> ADDRESS(13 downto 0),
			CLK         => CLK, 
			RST         => RST, 
			LCD_CS_N 	=> LCD_CS_N , 
			LCD_D 		=> LCD_D, 
			LCD_RD_N 	=> LCD_RD_N, 
			LCD_RESET_N => LCD_RESET_N, 
			LCD_RS 		=> LCD_RS, 
			LCD_WR_N 	=> LCD_WR_N
			);	
	
RAM: RAM16K
   PORT MAP(
		address	=> ADDRESS(13 downto 0),
		clock		=> CLK,
		data		=> INPUT,
		wren		=> LOAD_RAM,
		q		   => OUTPUT_RAM
	);

-- Controla LOAD das RAMs
LOAD_DISPLAY <= LOAD and ADDRESS(14);
LOAD_RAM <= LOAD and (not ADDRESS(14));

-- Saida do teclado
key_new <= s_key_new;
key_code <= s_key_code;
KEY <= "000000000"&s_key_code; -- output de teclado

--  Seletor do Multiplexador de saida
MUX_SEL1 <= ADDRESS(14) and ADDRESS(13) and ADDRESS(12) and ADDRESS(11) and ADDRESS(10) 
and ADDRESS(9) and ADDRESS(8)and ADDRESS(7)and ADDRESS(6) and ADDRESS(5) and ADDRESS(4)
and ADDRESS(3)and ADDRESS(2)and ADDRESS(1) and ADDRESS(0);
MUX_SEL2 <= (MUX_SEL1 and s_key_new) or ((not MUX_SEL1) and ADDRESS(14));
MUX_SEL <= MUX_SEL1&MUX_SEL2;
MUX_OUTPUT : Mux4Way16 port map (
	sel => MUX_SEL,
	a => OUTPUT_RAM,
	b => OUTPUT_DISPLAY,
	c => (others => '0'),
	d => KEY,
	q => OUTPUT
	);

END logic;

