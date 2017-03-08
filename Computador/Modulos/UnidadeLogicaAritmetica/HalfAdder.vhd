-- Half Adder

Library ieee;
use ieee.std_logic_1164.all;

entity HalfAdder is
	port(
		a,b:         in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end entity;
architecture HalfAdder_arch of HalfAdder is 
begin
 	soma <= a xor b;
	vaium	 <= a and b;
end architecture;	