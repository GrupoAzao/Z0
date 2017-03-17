-- Elementos de Sistemas
-- by Luciano Soares
-- ShiftRegisterPIPO16.vhd

-- shift register tipo PIPO de 16 bits:
-- If direction == 0 then out[t+1] = out[t] << 1
--                   else out[t+1] = out[t] >> 1
-- os novos bits podem ser preenchidos com 0

Library ieee; 
use ieee.std_logic_1164.all;

entity ShiftRegisterPIPO16 is
	port(
		clock:     in  STD_LOGIC;
		input:     in  STD_LOGIC_VECTOR(15 downto 0);
		direction: in  STD_LOGIC;
		output:    out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;
