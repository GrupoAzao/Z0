library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Add16 is
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		b   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;


architecture Add16_arch of Add16 is
signal carry1,carry2, carry3, carry4, carry5, carry6, carry7, carry8, carry9, carry10, carry11, carry12, carry13, carry14, carry15, carry16 : STD_LOGIC; 
component HalfAdder 

	port(
		a,b:         in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);

end component;
component FullAdder 
	port(
		a,b,c:      in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);

end component;

begin

   c : HalfAdder port map (a(0), b(0), q(0),carry1);
   d : FullAdder port map (a(1), b(1), carry1, q(1), carry2);
   e : FullAdder port map (a(2), b(2), carry2, q(2), carry3);
   f: FullAdder port map (a(3), b(3), carry3,q(3), carry4);
   g : FullAdder port map (a(4), b(4), carry4, q(4), carry5);
   h : FullAdder port map (a(5), b(5), carry5, q(5), carry6);
   i : FullAdder port map (a(6), b(6), carry6, q(6), carry7);
   j : FullAdder port map (a(7), b(7), carry7, q(7), carry8);
   k : FullAdder port map (a(8),b(8), carry8, q(8), carry9);
   l : FullAdder port map (a(9), b(9), carry9, q(9), carry10);
   m : FullAdder port map (a(10), b(10), carry10, q(10), carry11);
   n : FullAdder port map (a(11), b(11), carry11, q(11), carry12);
   p : FullAdder port map (a(12), b(12), carry12, q(12), carry13);
   r : FullAdder port map (a(13), b(13), carry13, q(13), carry14);
   s : FullAdder port map (a(14), b(14), carry14, q(14), carry15);
   t : FullAdder port map (a(15), b(15), carry15, q(15), carry16);

end architecture;