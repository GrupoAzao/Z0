-- Contador de 16bits
-- if (reset[t] == 1) out[t+1] = 0
-- else if (load[t] == 1)  out[t+1] = in[t]
-- else if (inc[t] == 1) out[t+1] = out[t] + 1
-- else out[t+1] = out[t]

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

  entity PC is
      port(
         clock     : in  STD_LOGIC;
 		increment : in  STD_LOGIC;
 		load      : in  STD_LOGIC;
 		reset     : in  STD_LOGIC;
         input     : in  STD_LOGIC_VECTOR(15 downto 0);
          output    : out STD_LOGIC_VECTOR(14 downto 0)
      );
  end entity;

architecture PC_arch of PC is
begin

PC_process : process(clock,increment,load,reset,input)
  variable last_output : STD_LOGIC_VECTOR(14 downto 0);
begin
  if clock'event and clock ='1' then

    if increment = '0' and load = '0' and reset = '0' then
      output <= "000000000000000";
      last_output := "000000000000000";

    elsif reset = '1' then
      output <= "000000000000000";
      last_output := "000000000000000";

    elsif load = '1' and increment = '1' then
      output <= STD_LOGIC_VECTOR(unsigned(input) +1);
      last_output := STD_LOGIC_VECTOR(unsigned(input) +1);

    elsif load = '1' then
      output <= input(14 downto 0);
      last_output := input(14 downto 0);


    elsif increment = '1' then
      output <= STD_LOGIC_VECTOR(unsigned(last_output) + 1);
      last_output := STD_LOGIC_VECTOR(unsigned(last_output) + 1);

    else
      output <= last_output;

	end if;
end if;

end process PC_process;
end PC_arch;
