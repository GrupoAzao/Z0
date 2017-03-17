-- Elementos de Sistemas
-- by Luciano Soares
-- ShiftRegisterSISO16.vhd

-- shift register tipo SISO de 16 bits:
-- out[t+15] = in[t], out[t+16] = in[t+1], out[t+17] = in[t+2], ...

Library ieee; 
use ieee.std_logic_1164.all;
  
entity ShiftRegisterSISO16 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		output: out STD_LOGIC
	);
end entity;
