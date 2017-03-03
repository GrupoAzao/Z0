library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DMux8Way is
	port ( 
			a:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q0:  out STD_LOGIC;
			q1:  out STD_LOGIC;
			q2:  out STD_LOGIC;
			q3:  out STD_LOGIC;
			q4:  out STD_LOGIC;
			q5:  out STD_LOGIC;
			q6:  out STD_LOGIC;
			q7:  out STD_LOGIC);
end entity;
architecture DMux8Way_arch of DMux8Way is
signal sel0_linha, sel1_linha, sel2_linha: STD_LOGIC;
begin
	sel0_linha <= not sel(0);
	sel1_linha <= not sel(1);
	sel2_linha <= not sel(2);
	q7 <= a and sel(0) and sel(1) and sel(2);
	q6 <= a and sel(0) and sel(1) and sel2_linha;
	q5 <= a and sel(0) and sel1_linha and sel(2);
	q4 <= a and sel(0) and sel1_linha and sel2_linha;
	q3 <= a and sel0_linha and sel(1) and sel(2);	
	q2 <= a and sel0_linha and sel(1) and sel2_linha;
	q1 <= a and sel0_linha and sel1_linha and sel(2);
	q0 <= a and sel0_linha and sel1_linha and sel2_linha;
end architecture;