library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegisterPISO16 is
    Port ( clock :  in   STD_LOGIC;
           shift : in   STD_LOGIC;
           input :    in   STD_LOGIC_VECTOR (15 downto 0);
           output :    out  STD_LOGIC);
end Piso;

architecture Behavioral of Piso is

  signal sr: std_logic_vector(15 downto 0) := (others=>'0');

begin

  process (clock,shift,input)
  begin
    if (shift = '1') then
      sr <= input;
    elsif rising_edge(clock) then
      sr <= '0' & sr(15 downto 1);
    end if;
  end process;

  output <= sr(0);      
 
end Behavioral;