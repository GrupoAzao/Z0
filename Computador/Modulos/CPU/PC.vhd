library ieee;
use ieee.std_logic_1164.all;

entity PC is
    port(
		clock     : in  STD_LOGIC;
		increment : in  STD_LOGIC;
		load      : in  STD_LOGIC;
		reset     : in  STD_LOGIC;
		input     : in  STD_LOGIC_VECTOR(15 downto 0);
		output    : out STD_LOGIC_VECTOR(14 downto 0));
end entity;

architecture ProgramCounter_arch of PC is

signal w1,w2,w3,w4,w7: STD_LOGIC_VECTOR(15 downto 0);
signal w5,w6: STD_LOGIC;

component Add16
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0); 
		b   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   :  out STD_LOGIC_VECTOR(15 downto 0)); 
end component;

component Mux16
	port( 
		a:   in  STD_LOGIC_VECTOR(15 downto 0); 
		b:   in  STD_LOGIC_VECTOR(15 downto 0);	
		sel: in  STD_LOGIC;
		q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Register16
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(15 downto 0);
		load:    in STD_LOGIC;
		output:  out STD_LOGIC_VECTOR(15 downto 0));
end component;


-- w1: saida do Mux16 para Reg16
-- w2: saida do Mux16 Reset, Input do Register16
-- w3: saida do Register16, Entrada Add
-- w4: saida do Add16
-- w5: inverso do Load
-- w6: Load
-- w7: Entrada Add = (15 bits + Incremento, 0 ou 1)

begin
	s1: Mux16 port map (input,w4,w5,w1);		-- Mux Load
	s2: Mux16 port map (w1,"0000000000000000",reset,w2); 	-- Mux Reset
	s3: Register16 port map (clock,w2,w6,w3); 	-- Registrador
	s4: Add16 port map (w3,w7,w4);	-- ADD: Output do Reg16 com W7

	w7 <= "000000000000000"&increment;	-- 15 bits + Incremento (concatenation)
	w5 <= not load;		-- Load negado
	w6 <= load or reset or increment;
	output <= w3(14 downto 0);		-- 15 bits

end architecture;