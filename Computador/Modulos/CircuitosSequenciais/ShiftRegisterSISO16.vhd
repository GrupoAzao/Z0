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
architecture arch_siso of ShiftRegisterSISO16 is 
signal w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15: STD_LOGIC;
component FlipFlopD
	port(
		clock:  in std_logic;
		d:      in std_logic;
		clear:  in std_logic;
		preset: in std_logic;
		q:     out std_logic
	);
end component;
begin
	u1: FlipFlopD port map (clock,input,'1', '1',w1);
	u2: FlipFlopD port map (clock,w1,'1', '1',w2);
	u3: FlipFlopD port map (clock,w2,'1', '1',w3);
	u4: FlipFlopD port map (clock,w3,'1', '1',w4);
	u5: FlipFlopD port map (clock,w4,'1', '1',w5);
	u6: FlipFlopD port map (clock,w5,'1', '1',w6);
	u7: FlipFlopD port map (clock,w6,'1', '1',w7);
	u8: FlipFlopD port map (clock,w7,'1', '1',w8);
	u9: FlipFlopD port map (clock,w8,'1', '1',w9);
	u10: FlipFlopD port map (clock,w9,'1', '1',w10);
	u11: FlipFlopD port map (clock,w10,'1', '1',w11);
	u12: FlipFlopD port map (clock,w11,'1', '1',w12);
	u13: FlipFlopD port map (clock,w12,'1', '1',w13);
	u14: FlipFlopD port map (clock,w13,'1', '1',w14);
	u16: FlipFlopD port map (clock,w14,'1', '1',w15);
	u17: FlipFlopD port map (clock,w15,'1', '1',output);
	
end architecture;
