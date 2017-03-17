-- Elementos de Sistemas
-- by Luciano Soares
-- ShiftRegisterSIPO16.vhd

-- shift register tipo SIPO de 16 bits:
-- out[0] = in[t], out[1] = in[t+1], out[2] = in[t+2], ...

Library ieee; 
use ieee.std_logic_1164.all;
  
entity ShiftRegisterSIPO16 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;
