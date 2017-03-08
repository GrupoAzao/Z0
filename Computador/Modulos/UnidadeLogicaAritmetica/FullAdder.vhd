-- Full Adder

Library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
	port(
		a,b,c:      in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end entity;
architecture arch_FullAdder of FullAdder is 
signal w1, w2, w3 : STD_LOGIC;
begin
	w1 <= a xor b;
	w2 <= a and b;
	w3 <=w1 and c;
	soma <= w1 xor c;
	vaium	 <= w3 or w2;
end architecture;