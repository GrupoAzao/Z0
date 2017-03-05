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

architecture behave of Dmux8Way is
begin
process (a, sel)
begin
if (sel = "000") then
	q2 <= '0';  
	q1 <= '0';
	q0 <= a;
	q3 <= '0';
	q4 <= '0';  
	q5 <= '0';
	q6 <= '0';
	q7 <= '0';
elsif (sel = "001") then
	q2 <= '0';  
	q0 <= '0';
	q1 <= a;
	q3 <= '0';
	q4 <= '0';  
	q5 <= '0';
	q6 <= '0';
	q7 <= '0';
elsif (sel = "010") then
	q0 <= '0';  
	q1 <= '0';
	q2 <= a;
	q3 <= '0';
	q4 <= '0';  
	q5 <= '0';
	q6 <= '0';
	q7 <= '0';

elsif (sel = "011") then
	q2 <= '0';  
	q1 <= '0';
	q3 <= a;
	q0 <= '0';
	q4 <= '0';  
	q5 <= '0';
	q6 <= '0';
	q7 <= '0';

 elsif (sel = "100") then
	q2 <= '0';  
	q1 <= '0';
	q4 <= a;
	q0 <= '0';
	q3 <= '0';  
	q5 <= '0';
	q6 <= '0';
	q7 <= '0';

elsif (sel = "101") then
	q2 <= '0';  
	q1 <= '0';
	q5 <= a;
	q0 <= '0';
	q4 <= '0';  
	q3 <= '0';
	q6 <= '0';
	q7 <= '0';

elsif (sel = "110") then
	q2 <= '0';  
	q1 <= '0';
	q6 <= a;
	q0 <= '0';
	q4 <= '0';  
	q5 <= '0';
	q3 <= '0';
	q7 <= '0';

else
	q2 <= '0';  
	q1 <= '0';
	q7 <= a;
	q0 <= '0';
	q4 <= '0';  
	q5 <= '0';
	q6 <= '0';
	q3 <= '0';
end if;
end process;
end architecture;