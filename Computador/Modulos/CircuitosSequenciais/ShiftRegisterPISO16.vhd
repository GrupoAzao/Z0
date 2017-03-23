library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegisterPISO16 is
    Port ( clock :  in   STD_LOGIC;
           shift: in   STD_LOGIC;
           input :    in   STD_LOGIC_VECTOR (15 downto 0);
           output :    out  STD_LOGIC);
end entity;

architecture arch_piso of ShiftRegisterPISO16 is

  signal w1: std_logic_vector(15 downto 0) := (others=>'0');

begin

  process (clock,shift,input)
  begin
    if (shift = '1') then
      w1 <= input;
    elsif rising_edge(clock) then
      w1 <= '0' & w1(15 downto 1);
    end if;
  end process;
  output <= w1(0);      
 
end architecture;