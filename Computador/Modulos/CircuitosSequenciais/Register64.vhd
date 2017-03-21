-- Elementos de Sistemas
-- by Luciano Soares
-- Register64.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Register64 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(63 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(63 downto 0)
	);
end entity;
architecture Register64_arch of Register64 is
component BinaryDigit
port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		load:    in STD_LOGIC;
		output: out STD_LOGIC
	);
end component;
begin
	e1: BinaryDigit port map (clock,input(63),load,output(63));
	e2: BinaryDigit port map (clock,input(62),load,output(62));
	e3: BinaryDigit port map (clock,input(61),load,output(61));
	e4: BinaryDigit port map (clock,input(60),load,output(60));
	e5: BinaryDigit port map (clock,input(59),load,output(59));
	e6: BinaryDigit port map (clock,input(58),load,output(58));
	e7: BinaryDigit port map (clock,input(57),load,output(57));
	e8: BinaryDigit port map (clock,input(56),load,output(56));

	e9: BinaryDigit port map (clock,input(55),load,output(55));
	e10: BinaryDigit port map (clock,input(54),load,output(54));
	e11: BinaryDigit port map (clock,input(53),load,output(53));
	e12: BinaryDigit port map (clock,input(52),load,output(52));
	e13: BinaryDigit port map (clock,input(51),load,output(51));
	e14: BinaryDigit port map (clock,input(50),load,output(50));
	e15: BinaryDigit port map (clock,input(49),load,output(49));
	e16: BinaryDigit port map (clock,input(48),load,output(48));

	e17: BinaryDigit port map (clock,input(47),load,output(47));
	e18: BinaryDigit port map (clock,input(46),load,output(46));
	e19: BinaryDigit port map (clock,input(45),load,output(45));
	e20: BinaryDigit port map (clock,input(44),load,output(44));
	e21: BinaryDigit port map (clock,input(43),load,output(43));
	e22: BinaryDigit port map (clock,input(42),load,output(42));
	e23: BinaryDigit port map (clock,input(41),load,output(41));
	e24: BinaryDigit port map (clock,input(40),load,output(40));

	e25: BinaryDigit port map (clock,input(39),load,output(39));
	e26: BinaryDigit port map (clock,input(38),load,output(38));
	e27: BinaryDigit port map (clock,input(37),load,output(37));
	e28: BinaryDigit port map (clock,input(36),load,output(36));
	e29: BinaryDigit port map (clock,input(35),load,output(35));
	e30: BinaryDigit port map (clock,input(34),load,output(34));
	e31: BinaryDigit port map (clock,input(33),load,output(33));
	e32: BinaryDigit port map (clock,input(32),load,output(32));

	e33: BinaryDigit port map (clock,input(31),load,output(31));
	e34: BinaryDigit port map (clock,input(30),load,output(30));
	e35: BinaryDigit port map (clock,input(29),load,output(29));
	e36: BinaryDigit port map (clock,input(28),load,output(28));
	e37: BinaryDigit port map (clock,input(27),load,output(27));
	e38: BinaryDigit port map (clock,input(26),load,output(26));
	e39: BinaryDigit port map (clock,input(25),load,output(25));
	e40: BinaryDigit port map (clock,input(24),load,output(24));

	e41: BinaryDigit port map (clock,input(23),load,output(23));
	e42: BinaryDigit port map (clock,input(22),load,output(22));
	e43: BinaryDigit port map (clock,input(21),load,output(21));
	e44: BinaryDigit port map (clock,input(20),load,output(20));
	e45: BinaryDigit port map (clock,input(19),load,output(19));
	e46: BinaryDigit port map (clock,input(18),load,output(18));
	e47: BinaryDigit port map (clock,input(17),load,output(17));
	e48: BinaryDigit port map (clock,input(16),load,output(16));

	e49: BinaryDigit port map (clock,input(15),load,output(15));
	e50: BinaryDigit port map (clock,input(14),load,output(14));
	e51: BinaryDigit port map (clock,input(13),load,output(13));
	e52: BinaryDigit port map (clock,input(12),load,output(12));
	e53: BinaryDigit port map (clock,input(11),load,output(11));
	e54: BinaryDigit port map (clock,input(10),load,output(10));
	e55: BinaryDigit port map (clock,input(9),load,output(9));
	e56: BinaryDigit port map (clock,input(8),load,output(8));

	e57: BinaryDigit port map (clock,input(7),load,output(7));
	e58: BinaryDigit port map (clock,input(6),load,output(6));
	e59: BinaryDigit port map (clock,input(5),load,output(5));
	e60: BinaryDigit port map (clock,input(4),load,output(4));
	e61: BinaryDigit port map (clock,input(3),load,output(3));
	e62: BinaryDigit port map (clock,input(2),load,output(2));
	e63: BinaryDigit port map (clock,input(1),load,output(1));
	e64: BinaryDigit port map (clock,input(0),load,output(0));


end architecture;