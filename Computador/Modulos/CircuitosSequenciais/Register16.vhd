
-- Elementos de Sistemas
-- by Luciano Soares
-- Register8.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register16 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(15 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;
architecture Register16_arch of Register16 is
component BinaryDigit
port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		load:    in STD_LOGIC;
		output: out STD_LOGIC
	);
end component;
begin
	e1: BinaryDigit port map (clock,input(15),load,output(15));
	e2: BinaryDigit port map (clock,input(14),load,output(14));
	e3: BinaryDigit port map (clock,input(13),load,output(13));
	e4: BinaryDigit port map (clock,input(12),load,output(12));
	e5: BinaryDigit port map (clock,input(11),load,output(11));
	e6: BinaryDigit port map (clock,input(10),load,output(10));
	e7: BinaryDigit port map (clock,input(9),load,output(9));
	e8: BinaryDigit port map (clock,input(8),load,output(8));
	e9: BinaryDigit port map (clock,input(7),load,output(7));
	e10: BinaryDigit port map (clock,input(6),load,output(6));
	e11: BinaryDigit port map (clock,input(5),load,output(5));
	e12: BinaryDigit port map (clock,input(4),load,output(4));
	e13: BinaryDigit port map (clock,input(3),load,output(3));
	e14: BinaryDigit port map (clock,input(2),load,output(2));
	e15: BinaryDigit port map (clock,input(1),load,output(1));
	e16: BinaryDigit port map (clock,input(0),load,output(0));
	
	
end architecture;