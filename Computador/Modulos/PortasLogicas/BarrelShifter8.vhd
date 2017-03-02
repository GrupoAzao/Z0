library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BarrelShifter8 is
	port ( 
			a:    in  STD_LOGIC_VECTOR(7 downto 0);   -- input vector
			dir:  in  std_logic;                       -- 0=>left 1=>right
			size: in  std_logic_vector(2 downto 0);    -- shift amount
			q:    out STD_LOGIC_VECTOR(7 downto 0));  -- output vector (shifted)
end entity;
architecture arch_BarrelShifter8 of BarrelShifter8 is
begin 
	with size select
		q <= a(0) & a(7 downto 1) when "001",
			  a(1 downto 0) & a(7 downto 2) when "010",
			  a(2 downto 0) & a(7 downto 3) when "011",
			  a(3 downto 0) & a(7 downto 4) when "100",
			  a(4 downto 0) & a(7 downto 5) when "101",
			  a(5 downto 0) & a(7 downto 6) when "110",
			  a(6 downto 0) & a(7) when "111",
			  a when others;
end architecture;