library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DMux2Way is
	port ( 
			a:   in  STD_LOGIC;
			sel: in  STD_LOGIC;
			q0:  out STD_LOGIC;
			q1:  out STD_LOGIC);
end entity;
architecture DMux2Way_arch of DMux2Way is
signal w1 : STD_LOGIC;
begin
		w1 <= not sel;
		q0 <= w1 and a;
		q1 <= sel and a;
end architecture;