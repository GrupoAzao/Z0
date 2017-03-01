library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2Way is
	port ( 
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			sel: in  STD_LOGIC;
			q:   out STD_LOGIC);
end entity;
architecture Mux2Way_arch of Mux2Way is
signal sel_linha,w1,w2:STD_LOGIC;
begin
	sel_linha <= not sel;
	w1 <= a and sel_linha;
	w2 <= b and sel;
	q <= w1 or w2;
end architecture;