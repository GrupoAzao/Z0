library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DMux4Way is
	port ( 
			a:   in  STD_LOGIC;
			sel: in  STD_LOGIC_VECTOR(1 downto 0);
			q0:  out STD_LOGIC;
			q1:  out STD_LOGIC;
			q2:  out STD_LOGIC;
			q3:  out STD_LOGIC);
end entity;
architecture DMux4Way_arch of DMux4Way is
signal sel0_linha, sel1_linha: STD_LOGIC;
begin
	sel0_linha <= not sel(0);
	sel1_linha <= not sel(1);
	q0 <= a and sel0_linha and sel1_linha;
	q1 <= a and sel(0) and sel1_linha;
	q2 <= a and sel0_linha and sel(1);
	q3 <= a and sel(0) and sel(1);
end architecture;