library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShifterRegisterPISO16 is
    Port ( clock :  in   STD_LOGIC;
           shift : in   STD_LOGIC;
           input :    in   STD_LOGIC_VECTOR (15 downto 0);
           output :    out  STD_LOGIC);
end ShifterRegisterPISO16;

architecture Behavioral of ShifterRegisterPISO16 is

  signal sr: std_logic_vector(15 downto 0) := (others=>'0');

begin

  process (clock,shift,input)
  begin
    if (shift = '0') then
      sr <= input;
    elsif rising_edge(clock) then
      sr <= '0' & sr(15 downto 1);
    end if;
  end process;

  output <= sr(0);      
 
end Behavioral;