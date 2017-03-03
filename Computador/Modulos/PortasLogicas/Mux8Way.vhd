library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux8Way is
	port ( 
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			c:   in  STD_LOGIC;
			d:   in  STD_LOGIC;
			e:   in  STD_LOGIC;
			f:   in  STD_LOGIC;
			g:   in  STD_LOGIC;
			h:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q:   out STD_LOGIC);
end entity;
architecture Mux8Way_arch of Mux8Way is
signal sel0_linha, sel1_linha, sel2_linha, y0, y1, y2, y3,y4, y5, y6, y7: STD_LOGIC;
begin
	sel0_linha <= not sel(0);
	sel1_linha <= not sel(1);
	sel2_linha <= not sel(2);
	y7 <= h and sel(0) and sel(1) and sel(2);
	y3 <= d and sel(0) and sel(1) and sel2_linha;
	y5 <= f and sel(0) and sel1_linha and sel(2);
	y1 <= b and sel(0) and sel1_linha and sel2_linha;
	y6 <= g and sel0_linha and sel(1) and sel(2);	
	y2 <= c and sel0_linha and sel(1) and sel2_linha;
	y4 <= e and sel0_linha and sel1_linha and sel(2);
	y0 <= a and sel0_linha and sel1_linha and sel2_linha;
	q <= y0 or y1 or y2 or y3 or y4 or y5 or y6 or y7;
end architecture;