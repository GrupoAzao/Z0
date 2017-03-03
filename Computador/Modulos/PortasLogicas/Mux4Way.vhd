library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4Way is
	port ( 
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			c:   in  STD_LOGIC;
			d:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(1 downto 0);
			q:   out STD_LOGIC);
end entity;
architecture Mux4Way_arch of Mux4Way is
signal sel0_linha, sel1_linha, y0, y1, y2, y3: STD_LOGIC;
begin
	sel0_linha <= not sel(0);
	sel1_linha <= not sel(1);
	y0 <= a and sel0_linha and sel1_linha;
	y1 <= b and sel(0) and sel1_linha;
	y2 <= c and sel0_linha and sel(1);
	y3 <= d and sel(0) and sel(1);
	q <= y0 or y1 or y2 or y3;
end architecture;