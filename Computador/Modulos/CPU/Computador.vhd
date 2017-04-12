-------------------------------------------------------------------
-- Elementos de Sistemas
-------------------------------------------------------------------
-- Luciano Pereira
-------------------------------------------------------------------
-- Descricao :
-- Entidade central do desenvolvimento do computador
-------------------------------------------------------------------
-- Historico:
--  29/11/2016 : Criacao do projeto
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Computador is

   PORT(
        -- Sistema
        CLK          : IN    STD_LOGIC;
        RST          : IN    STD_LOGIC;		  
		  LED          : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0);
		  DIP_SW       : IN    STD_LOGIC_VECTOR(3 DOWNTO 0);

        -- LCD EXTERNAL I/OS
        LCD_CS_N     : OUT   STD_LOGIC;	
        LCD_D        : INOUT STD_LOGIC_VECTOR(15 downto 0);
        LCD_RD_N     : OUT   STD_LOGIC;	
        LCD_RESET_N  : OUT   STD_LOGIC;	
        LCD_RS       : OUT   STD_LOGIC;	      -- (DCx) 0 : reg, 1: command
        LCD_WR_N     : OUT   STD_LOGIC;
		  LCD_ON       : OUT   STD_LOGIC := '1';	-- liga e desliga o LCD
		
		  -- Teclado
		  key_clk      : IN    STD_LOGIC;         -- clock signal from PS/2 keyboard
		  key_data     : IN    STD_LOGIC;         -- data signal from PS/2 keyboard
		  
		   -- Signals to/from the SDRAM chip
        DRAM_ADDR    : OUT   STD_LOGIC_VECTOR (12 downto 0);
        DRAM_BA      : OUT   STD_LOGIC_VECTOR (1 downto 0);
        DRAM_CAS_N   : OUT   STD_LOGIC;
        DRAM_CKE     : OUT   STD_LOGIC;
        DRAM_CLK     : OUT   STD_LOGIC;
        DRAM_CS_N    : OUT   STD_LOGIC;
        DRAM_DQ      : INOUT STD_LOGIC_VECTOR(15 downto 0);
        DRAM_DQM     : OUT   STD_LOGIC_VECTOR(1 downto 0);
        DRAM_RAS_N   : OUT   STD_LOGIC;
        DRAM_WE_N    : OUT   STD_LOGIC
        
       );
end entity;


ARCHITECTURE logic OF Computador IS

	component CPU is
		 port(
			  clock:	      in  STD_LOGIC;
			  inM:         in  STD_LOGIC_VECTOR(15 downto 0);
			  instruction: in  STD_LOGIC_VECTOR(15 downto 0);
			  reset:       in  STD_LOGIC;
			  outM:        out STD_LOGIC_VECTOR(15 downto 0);
			  writeM:      out STD_LOGIC;
			  addressM:    out STD_LOGIC_VECTOR(14 downto 0);
			  pcout:       out STD_LOGIC_VECTOR(14 downto 0)
	  );
	end component;

	component ROM32K IS
		PORT
		(
			address	 : IN STD_LOGIC_VECTOR (14 DOWNTO 0);
			clock		 : IN STD_LOGIC  := '1';
			q		    : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
	END component;

	component MemoryIO is
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
			  --LCD_ACK 		: OUT STD_LOGIC;
			
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


	SIGNAL CLK_2KHZ      : STD_LOGIC;

	SIGNAL RST_INTERNAL  : STD_LOGIC := '1';

	SIGNAL INPUT         : STD_LOGIC_VECTOR(15 downto 0) := "1111111111111111";
	SIGNAL ADDRESS       : STD_LOGIC_VECTOR(14 downto 0) := "100000000000000";

	SIGNAL LOAD_CPU      : STD_LOGIC := '0';
	SIGNAL INPUT_CPU     : STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL ADDRESS_CPU   : STD_LOGIC_VECTOR(14 downto 0);

	SIGNAL LOAD_MEMORY   : STD_LOGIC := '0';
	SIGNAL INPUT_MEMORY  : STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL ADDRESS_MEMORY: STD_LOGIC_VECTOR(14 downto 0);

	SIGNAL OUTPUT_RAM    : STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL INSTRUCTION   : STD_LOGIC_VECTOR(15 downto 0);
	SIGNAL PC			   : STD_LOGIC_VECTOR(14 downto 0);

	SIGNAL S_key_code    : STD_LOGIC_VECTOR(6 downto 0);
	SIGNAL S_key_new     : STD_LOGIC;

BEGIN

	MAIN_CPU : CPU PORT MAP (
			clock =>       CLK_2KHZ,
			inM =>         OUTPUT_RAM,
			instruction => INSTRUCTION,
			reset =>       RST_INTERNAL,
			outM =>        INPUT_CPU,
			writeM =>      LOAD_CPU,  
			addressM =>    ADDRESS_CPU,
			pcout =>       PC
	  );

	ROM : ROM32K PORT MAP (
			address	 => PC(14 downto 0),
			clock		 => CLK_2KHZ,
			q		    => INSTRUCTION
		);

	MEMORY_MAPED : MemoryIO PORT MAP (
			CLK         => CLK, 
			RST         => RST,
			ADDRESS		=> ADDRESS_MEMORY,
			INPUT       => INPUT_MEMORY,
			LOAD        => LOAD_MEMORY,
			OUTPUT		=> OUTPUT_RAM,
			LCD_CS_N 	=> LCD_CS_N , 
			LCD_D 		=> LCD_D, 
			LCD_RD_N 	=> LCD_RD_N, 
			LCD_RESET_N => LCD_RESET_N, 
			LCD_RS 		=> LCD_RS, 
			LCD_WR_N 	=> LCD_WR_N,
			--LCD_ACK 		=> LCD_ACK,
			key_clk     => key_clk,
			key_data    => key_data,
			key_code    => s_key_code,
			key_new     => s_key_new,
			DRAM_ADDR      => DRAM_ADDR,
			DRAM_BA        => DRAM_BA,
			DRAM_CAS_N     => DRAM_CAS_N,
			DRAM_CKE       => DRAM_CKE,
			DRAM_CLK       => DRAM_CLK,
			DRAM_CS_N      => DRAM_CS_N,
			DRAM_DQ        => DRAM_DQ,
			DRAM_DQM       => DRAM_DQM,
			DRAM_RAS_N     => DRAM_RAS_N,
			DRAM_WE_N      => DRAM_WE_N
		 );
				
	PLL_inst : PLL PORT MAP (
			areset	 => '0',
			inclk0	 => CLK,
			c0			 => OPEN,
			c1	 		 => CLK_2KHZ,
			locked	 => OPEN
		);

		
	---- DIPSWITCHS
	with DIP_SW select LED <=
		 s_key_code&s_key_new       when "0000",
		 PC(7 downto 0)             when "0001",
		 INSTRUCTION(7 downto 0)    when "0010",
		 ADDRESS_MEMORY(7 downto 0) when "0011",
		 INPUT_MEMORY(7 downto 0)   when "0100",
		 OUTPUT_RAM(7 downto 0)     when "0101",
		 "00000000"                 when others;

	INPUT_MEMORY <= INPUT_CPU when RST_INTERNAL = '0' else INPUT;
	LOAD_MEMORY <= LOAD_CPU or RST_INTERNAL;
	ADDRESS_MEMORY <= ADDRESS_CPU when RST_INTERNAL = '0' else ADDRESS;

	process (CLK_2KHZ, RST)
	variable aguarda : integer := 0;
	begin

		-- Inicializacao	
		if(rising_edge(CLK_2KHZ)) then
			if(RST = '1') then
				if(aguarda > 4800) then
					RST_INTERNAL <= '0';
					LCD_ON <= '1';
				else
					aguarda := aguarda + 1;
					INPUT <= "0000000000000000";  -- apaga as linhas
					ADDRESS <= std_logic_vector(to_unsigned( aguarda + 16384,15));  -- apaga as linhas
				end if;
			else
				RST_INTERNAL <= '1';
				aguarda := 0;
				LCD_ON <= '0';
				INPUT <= "0000000000000000";	   -- apaga a primeira linha
				ADDRESS <= "100000000000000";	   -- apaga a primeira linha
			end if;
		end if;
			
	end process;

end logic;


