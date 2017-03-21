-- Elementos de Sistemas
-- by Luciano Soares
-- Register32.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register32 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(31 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(31 downto 0)
	);
end entity;


architecture Register32_arch of Register32 is

component BinaryDigit
port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		load:    in STD_LOGIC;
		output: out STD_LOGIC
	);
end component;
begin
	e1: BinaryDigit port map (clock,input(31),load,output(31));
	e2: BinaryDigit port map (clock,input(30),load,output(30));
	e3: BinaryDigit port map (clock,input(29),load,output(29));
	e4: BinaryDigit port map (clock,input(28),load,output(28));
	e5: BinaryDigit port map (clock,input(27),load,output(27));
	e6: BinaryDigit port map (clock,input(26),load,output(26));
	e7: BinaryDigit port map (clock,input(25),load,output(25));
	e8: BinaryDigit port map (clock,input(24),load,output(24));
	e9: BinaryDigit port map (clock,input(23),load,output(23));
	e10: BinaryDigit port map (clock,input(22),load,output(22));
	e11: BinaryDigit port map (clock,input(21),load,output(21));
	e12: BinaryDigit port map (clock,input(20),load,output(20));
	e13: BinaryDigit port map (clock,input(19),load,output(19));
	e14: BinaryDigit port map (clock,input(18),load,output(18));
	e15: BinaryDigit port map (clock,input(17),load,output(17));
	e16: BinaryDigit port map (clock,input(16),load,output(16));
	e17: BinaryDigit port map (clock,input(15),load,output(15));
	e18: BinaryDigit port map (clock,input(14),load,output(14));
	e19: BinaryDigit port map (clock,input(13),load,output(13));
	e20: BinaryDigit port map (clock,input(12),load,output(12));
	e21: BinaryDigit port map (clock,input(11),load,output(11));
	e22: BinaryDigit port map (clock,input(10),load,output(10));
	e23: BinaryDigit port map (clock,input(9),load,output(9));
	e24: BinaryDigit port map (clock,input(8),load,output(8));
	e25: BinaryDigit port map (clock,input(7),load,output(7));
	e26: BinaryDigit port map (clock,input(6),load,output(6));
	e27: BinaryDigit port map (clock,input(5),load,output(5));
	e28: BinaryDigit port map (clock,input(4),load,output(4));
	e29: BinaryDigit port map (clock,input(3),load,output(3));
	e30: BinaryDigit port map (clock,input(2),load,output(2));
	e31: BinaryDigit port map (clock,input(1),load,output(1));
	e32: BinaryDigit port map (clock,input(0),load,output(0));
	
end architecture;