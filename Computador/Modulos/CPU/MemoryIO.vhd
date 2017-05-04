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
		  INPUT			: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		  LOAD			: IN STD_LOGIC ;
		  OUTPUT			: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		  
        -- LCD EXTERNAL I/OS
        LCD_CS_N     : OUT   STD_LOGIC;	
        LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
        LCD_RD_N     : OUT   STD_LOGIC;	
        LCD_RESET_N  : OUT   STD_LOGIC;	
        LCD_RS       : OUT   STD_LOGIC;	-- (DCx) 0 : reg, 1: command
        LCD_WR_N     : OUT   STD_LOGIC;	
		  LCD_ON       : OUT   STD_LOGIC := '1';	-- liga e desliga o LCD

		  LCD_ACK 		: OUT STD_LOGIC;

		  -- Teclado
		  key_clk      : IN  STD_LOGIC;                     --clock signal from PS/2 keyboard
		  key_data     : IN  STD_LOGIC;                     --data signal from PS/2 keyboard
        key_code     : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); --code received from PS/2
		  key_new      : OUT STD_LOGIC;                     --output flag indicating new ASCII value

		  -- Signals to/from the SDRAM chip
        DRAM_ADDR   : OUT   STD_LOGIC_VECTOR (12 downto 0);
        DRAM_BA      : OUT   STD_LOGIC_VECTOR (1 downto 0);
        DRAM_CAS_N   : OUT   STD_LOGIC;
        DRAM_CKE      : OUT   STD_LOGIC;
        DRAM_CLK      : OUT   STD_LOGIC;
        DRAM_CS_N   : OUT   STD_LOGIC;
        DRAM_DQ      : INOUT STD_LOGIC_VECTOR(15 downto 0);
        DRAM_DQM      : OUT   STD_LOGIC_VECTOR(1 downto 0);
        DRAM_RAS_N   : OUT   STD_LOGIC;
        DRAM_WE_N    : OUT   STD_LOGIC

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
		  --OUTPUT : OUT STD_LOGIC_VECTOR(15 downto 0);
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
		  --LCD_ON       : OUT   STD_LOGIC	
       );
end component;

component RAM16K IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (13 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		   : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end component;

--component interfaceSDRAM is
--
--    PORT(
--        -- Sistema
--        CLK_50  : IN  STD_LOGIC; -- 50 Mhz
--		    RST			: in std_logic;
--  
--        -- I/Os digital
--		    CPU_INPUT : in std_logic_vector(15 downto 0) := (others => '0');
--        CPU_OUTPUT : out std_logic_vector(15 downto 0) := (others => '0');
--        CPU_ADDRESS : in std_logic_vector(13 downto 0) := (others => '0');
--		    CPU_LOAD  : IN  STD_LOGIC;
--		  
--        -- SDRAM
--        DRAM_ADDR   : out   std_logic_vector(12 downto 0);
--        DRAM_BA     : out   std_logic_vector(1  downto 0);
--        DRAM_CAS_N  : out   std_logic;  
--        DRAM_CKE    : out   std_logic;
--        DRAM_CLK    : out   std_logic;
--        DRAM_CS_N   : out   std_logic;
--        DRAM_DQ     : inout std_logic_vector(15 downto 0);
--        DRAM_DQM    : out   std_logic_vector(01 downto 0);
--        DRAM_RAS_N  : out   std_logic;
--        DRAM_WE_N   : out   std_logic
--    );
--end component;

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
    Port ( sel : in  STD_LOGIC_VECTOR (1 downto 0);     -- select input
           a   : in  STD_LOGIC_VECTOR (15 downto 0);     -- inputs
			  b   : in  STD_LOGIC_VECTOR (15 downto 0);     -- inputs
			  c   : in  STD_LOGIC_VECTOR (15 downto 0);     -- inputs
			  d   : in  STD_LOGIC_VECTOR (15 downto 0);     -- inputs
           q   : out STD_LOGIC_VECTOR (15 downto 0));    -- output
end component;

SIGNAL LOAD_RAM          : STD_LOGIC := '0';
SIGNAL LOAD_DISPLAY      : STD_LOGIC := '0';

SIGNAL CLK_2KHZ      : STD_LOGIC;

SIGNAL CLK_1MKHZ     : STD_LOGIC;

SIGNAL OUTPUT_RAM         : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL OUTPUT_DISPLAY         : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL MUX_SEL         : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL MUX_SEL1     : STD_LOGIC;
SIGNAL MUX_SEL2     : STD_LOGIC;
SIGNAL KEY         : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL s_key_code     :  STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL s_key_new      :  STD_LOGIC;

	SIGNAL RST_INTERNAL  : STD_LOGIC := '1';
	
	SIGNAL INPUT_INTERNAL : STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL ADDRESS_INTERNAL   : STD_LOGIC_VECTOR(14 downto 0);
	
	SIGNAL LOAD_SCREEN   : STD_LOGIC := '0';
	SIGNAL INPUT_SCREEN  : STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL ADDRESS_SCREEN: STD_LOGIC_VECTOR(14 downto 0);
	
		TYPE   STATE_TYPE IS (
	   s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14,
		t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14,
		c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14,
		d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14
		);
   SIGNAL state   : STATE_TYPE;

BEGIN

TECLADO: ps2_keyboard_to_ascii  port map (
    clk          	=> CLK, 
    ps2_clk      	=> key_clk,
    ps2_data     	=> key_data,
	 ascii_new 		=> s_key_new,
    ascii_code 	=> s_key_code
	 );

DISPLAY: Screen  port map (
         INPUT       => INPUT_SCREEN,
			LOAD        => LOAD_SCREEN,
			ADDRESS		=> ADDRESS_SCREEN(13 downto 0),
			--OUTPUT		=> OUTPUT_DISPLAY,
			CLK         => CLK, 
			RST         => RST, 
			--LCD_ACK 		=> LCD_ACK,
			LCD_CS_N 	=> LCD_CS_N , 
			LCD_D 		=> LCD_D, 
			LCD_RD_N 	=> LCD_RD_N, 
			LCD_RESET_N => LCD_RESET_N, 
			LCD_RS 		=> LCD_RS, 
			LCD_WR_N 	=> LCD_WR_N
			);	

--RAM: interfaceSDRAM
--   PORT MAP(
--         CLK_50		=> CLK,
--			RST			=> RST,
--			CPU_INPUT   => INPUT,
--			CPU_OUTPUT		=> OUTPUT_RAM,
--
--			CPU_ADDRESS		=> ADDRESS(13 downto 0),
--			CPU_LOAD       => LOAD_RAM,
--			
--			DRAM_ADDR      => DRAM_ADDR,
--   		DRAM_BA        => DRAM_BA,
--   		DRAM_CAS_N     => DRAM_CAS_N,
--   		DRAM_CKE       => DRAM_CKE,
--   		DRAM_CLK       => DRAM_CLK,
--   		DRAM_CS_N      => DRAM_CS_N,
--   		DRAM_DQ        => DRAM_DQ,
--   		DRAM_DQM       => DRAM_DQM,
--   		DRAM_RAS_N     => DRAM_RAS_N,
--   		DRAM_WE_N      => DRAM_WE_N
--
--	);
	
RAM: RAM16K
   PORT MAP(
		address	=> ADDRESS(13 downto 0),
		clock		=> CLK,
		data		=> INPUT,
		wren		=> LOAD_RAM,
		q		   => OUTPUT_RAM
	);

		PLL_inst : PLL PORT MAP (
			areset	 => '0',
			inclk0	 => CLK,
			c0			 => OPEN,
			c1	 		 => CLK_2KHZ,
			locked	 => OPEN
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
	
	INPUT_SCREEN <= INPUT when RST_INTERNAL = '0' else INPUT_INTERNAL;
	LOAD_SCREEN <= LOAD_DISPLAY or RST_INTERNAL;
	ADDRESS_SCREEN <= ADDRESS when RST_INTERNAL = '0' else ADDRESS_INTERNAL;
	
	LCD_ACK <= not RST_INTERNAL;
	
	process (CLK_2KHZ, RST)
	variable aguarda : integer := 0;
	begin

		-- Inicializacao	
		if(rising_edge(CLK_2KHZ)) then
			if(RST = '1') then
				if(aguarda > 6800) then   --if(aguarda > 4800) then
					RST_INTERNAL <= '0';
					
				elsif(aguarda > 6768) then
					aguarda := aguarda + 1;
					CASE state IS
					
						-- APAGA Z
						WHEN c0 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100000101001";
							state <= c1;
						WHEN c1 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100000111101";
							state <= c2;
						WHEN c2 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100001010001";
							state <= c3;
						WHEN c3 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100001100101";
							state <= c4;
						WHEN c4 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100001111001";
							state <= c5;
						WHEN c5 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100010001101";
							state <= c6;
						WHEN c6 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100010100001";
							state <= c7;
						WHEN c7 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100010110101";
							state <= c8;
						WHEN c8 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100011001001";
							state <= c9;
						WHEN c9 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100011011101";
							state <= c10;
						WHEN c10 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100011110001";
							state <= c11;
						WHEN c11 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100100000101";
							state <= c12;
						WHEN c12 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100100011001";
							state <= c13;
						WHEN c13 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100100101101";
							state <= c14;
						WHEN c14 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100101000001";
							state <= d0;
							
						-- APAGA 0
						WHEN d0 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100000101010";
							state <= d1;
						WHEN d1 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100000111110";
							state <= d2;
						WHEN d2 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100001010010";
							state <= d3;
						WHEN d3 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100001100110";
							state <= d4;
						WHEN d4 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100001111010";
							state <= d5;
						WHEN d5 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100010001110";
							state <= d6;
						WHEN d6 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100010100010";
							state <= d7;
						WHEN d7 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100010110110";
							state <= d8;
						WHEN d8 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100011001010";
							state <= d9;
						WHEN d9 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100011011110";
							state <= d10;
						WHEN d10 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100011110010";
							state <= d11;
						WHEN d11 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100100000110";
							state <= d12;
						WHEN d12 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100100011010";
							state <= d13;
						WHEN d13 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100100101110";
							state <= d14;
						WHEN d14 => 
							INPUT_INTERNAL <= "0000000000000000";
							ADDRESS_INTERNAL <= "100100101000010";
							state <= s0;

						WHEN OTHERS =>
							state <= c0;
					END CASE;
					
					
				elsif(aguarda > 4800) then
					LCD_ON <= '1';
					aguarda := aguarda + 1;
					CASE state IS
					
					   -- ESCREVE Z
						WHEN s0 => 
							INPUT_INTERNAL <= "0111111111111110";
							ADDRESS_INTERNAL <= "100100000101001";
							state <= s1;
						WHEN s1 => 
							INPUT_INTERNAL <= "0111111111111110";
							ADDRESS_INTERNAL <= "100100000111101";
							state <= s2;
						WHEN s2 => 
							INPUT_INTERNAL <= "0111100000000000";
							ADDRESS_INTERNAL <= "100100001010001";
							state <= s3;
						WHEN s3 => 
							INPUT_INTERNAL <= "0011110000000000";
							ADDRESS_INTERNAL <= "100100001100101";
							state <= s4;
						WHEN s4 => 
							INPUT_INTERNAL <= "0001111000000000";
							ADDRESS_INTERNAL <= "100100001111001";
							state <= s5;
						WHEN s5 => 
							INPUT_INTERNAL <= "0000111100000000";
							ADDRESS_INTERNAL <= "100100010001101";
							state <= s6;
						WHEN s6 => 
							INPUT_INTERNAL <= "0000011110000000";
							ADDRESS_INTERNAL <= "100100010100001";
							state <= s7;
						WHEN s7 => 
							INPUT_INTERNAL <= "0000001111000000";
							ADDRESS_INTERNAL <= "100100010110101";
							state <= s8;
						WHEN s8 => 
							INPUT_INTERNAL <= "0000000111100000";
							ADDRESS_INTERNAL <= "100100011001001";
							state <= s9;
						WHEN s9 => 
							INPUT_INTERNAL <= "0000000011110000";
							ADDRESS_INTERNAL <= "100100011011101";
							state <= s10;
						WHEN s10 => 
							INPUT_INTERNAL <= "0000000001111000";
							ADDRESS_INTERNAL <= "100100011110001";
							state <= s11;
						WHEN s11 => 
							INPUT_INTERNAL <= "0000000000111100";
							ADDRESS_INTERNAL <= "100100100000101";
							state <= s12;
						WHEN s12 => 
							INPUT_INTERNAL <= "0000000000011110";
							ADDRESS_INTERNAL <= "100100100011001";
							state <= s13;
						WHEN s13 => 
							INPUT_INTERNAL <= "0111111111111110";
							ADDRESS_INTERNAL <= "100100100101101";
							state <= s14;
						WHEN s14 => 
							INPUT_INTERNAL <= "0111111111111110";
							ADDRESS_INTERNAL <= "100100101000001";
							state <= t0;
							
							
					   -- ESCREVE 0
						WHEN t0 => 
							INPUT_INTERNAL <= "0001111111111000";
							ADDRESS_INTERNAL <= "100100000101010";
							state <= t1;
						WHEN t1 => 
							INPUT_INTERNAL <= "0011111111111100";
							ADDRESS_INTERNAL <= "100100000111110";
							state <= t2;
						WHEN t2 => 
							INPUT_INTERNAL <= "0111000000000110";
							ADDRESS_INTERNAL <= "100100001010010";
							state <= t3;
						WHEN t3 => 
							INPUT_INTERNAL <= "0111100000000110";
							ADDRESS_INTERNAL <= "100100001100110";
							state <= t4;
						WHEN t4 => 
							INPUT_INTERNAL <= "0110110000000110";
							ADDRESS_INTERNAL <= "100100001111010";
							state <= t5;
						WHEN t5 => 
							INPUT_INTERNAL <= "0110011000000110";
							ADDRESS_INTERNAL <= "100100010001110";
							state <= t6;
						WHEN t6 => 
							INPUT_INTERNAL <= "0110001100000110";
							ADDRESS_INTERNAL <= "100100010100010";
							state <= t7;
						WHEN t7 => 
							INPUT_INTERNAL <= "0110000110000110";
							ADDRESS_INTERNAL <= "100100010110110";
							state <= t8;
						WHEN t8 => 
							INPUT_INTERNAL <= "0110000011000110";
							ADDRESS_INTERNAL <= "100100011001010";
							state <= t9;
						WHEN t9 => 
							INPUT_INTERNAL <= "0110000001100110";
							ADDRESS_INTERNAL <= "100100011011110";
							state <= t10;
						WHEN t10 => 
							INPUT_INTERNAL <= "0110000000110110";
							ADDRESS_INTERNAL <= "100100011110010";
							state <= t11;
						WHEN t11 => 
							INPUT_INTERNAL <= "0110000000011110";
							ADDRESS_INTERNAL <= "100100100000110";
							state <= t12;
						WHEN t12 => 
							INPUT_INTERNAL <= "0110000000001110";
							ADDRESS_INTERNAL <= "100100100011010";
							state <= t13;
						WHEN t13 => 
							INPUT_INTERNAL <= "0011111111111100";
							ADDRESS_INTERNAL <= "100100100101110";
							state <= t14;
						WHEN t14 => 
							INPUT_INTERNAL <= "0001111111111000";
							ADDRESS_INTERNAL <= "100100101000010";
							state <= c0;
							
						WHEN OTHERS =>
							state <= s0;
					END CASE;
				else
					aguarda := aguarda + 1;
					INPUT_INTERNAL <= "0000000000000000";  -- apaga as linhas
					ADDRESS_INTERNAL <= std_logic_vector(to_unsigned( aguarda + 16384,15));  -- apaga as linhas
				end if;
			else
				state <= s0;
				RST_INTERNAL <= '1';
				aguarda := 0;
				LCD_ON <= '0';
				INPUT_INTERNAL <= "0000000000000000";	   -- apaga a primeira linha
				ADDRESS_INTERNAL <= "100000000000000";	   -- apaga a primeira linha
			end if;
		end if;
			
	end process;

END logic;

