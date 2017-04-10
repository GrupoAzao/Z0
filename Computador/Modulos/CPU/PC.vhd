-- Contador de 16bits
-- if (reset[t] == 1) out[t+1] = 0
-- else if (load[t] == 1)  out[t+1] = in[t]
-- else if (inc[t] == 1) out[t+1] = out[t] + 1
-- else out[t+1] = out[t]

library ieee;
use ieee.std_logic_1164.all;

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
