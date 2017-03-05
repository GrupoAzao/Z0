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
	q <= a when (dir = '0' and size = "000") else
		  a(7 downto 1) & a(0) when (dir = '0' and size = "001") else
		  a(7 downto 2) & a(1 downto 0) when (dir = '0' and size = "010") else
	     a(7 downto 3) & a(2 downto 0) when (dir = '0' and size = "011") else
		  a(7 downto 4) & a(3 downto 0) when (dir = '0' and size = "100") else
		  a when (dir = '1' and size = "000") else
		  a(7) & a(6 downto 0)  when (dir = '1' and size = "001") else
		  a(7 downto 6) & a(5 downto 0) when (dir = '1' and size = "010") else
	     a(7 downto 5) & a(4 downto 0)  when (dir = '1' and size = "011") else
	     a(7 downto 4) & a(3 downto 0)  when (dir = '1' and size = "100");
	
end architecture;