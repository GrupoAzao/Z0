-- Elementos de Sistemas
-- by Luciano Soares
-- shift_certoRegisterPISO16.vhd

-- shift_certo register tipo PISO de 16 bits:
-- If shift_certo == 1 then shift_certo in
-- out = in[0], out = in[1], out = in[2], ...
-- os outros bits podem ser preenchidos com 0

Library ieee; 
use ieee.std_logic_1164.all;

entity ShiftRegisterPISO16 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(15 downto 0);
		shift:   in STD_LOGIC;
		output: out STD_LOGIC
	);
end entity;
architecture ShiftRegisterPISO16_arch of ShiftRegisterPISO16 is
signal w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17,w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31: STD_LOGIC;
component FlipFlopD
	port(
		clock:  in std_logic;
		d:      in std_logic;
		clear:  in std_logic;
		preset: in std_logic;
		q:     out std_logic
	);
end component;
component Mux2way
		port ( 
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			sel: in  STD_LOGIC;
			q:   out STD_LOGIC);
end component;
begin
	shift_certo <= not shift;
	u1: Mux2way port map ('0',input(0),shift_certo,w1);
	u2: FlipFlopD port map (clock,w1,'1', '1',w2);
	u3: Mux2way port map (w2,input(1),shift_certo,w3);
	u4: FlipFlopD port map (clock,w3,'1', '1',w4);
	u5: Mux2way port map (w4,input(2),shift_certo,w5);
	u6: FlipFlopD port map (clock,w5,'1', '1',w6);
	u7: Mux2way port map (w6,input(3),shift_certo,w7);
	u8: FlipFlopD port map (clock,w7,'1', '1',w8);
	u9: Mux2way port map (w8,input(4),shift_certo,w9);
	u10: FlipFlopD port map (clock,w9,'1', '1',w10);
	u11: Mux2way port map (w10,input(5),shift_certo,w11);
	u12: FlipFlopD port map (clock,w11,'1', '1',w12);
	u13: Mux2way port map (w12,input(6),shift_certo,w13);
	u14: FlipFlopD port map (clock,w13,'1', '1',w14);
	u15: Mux2way port map (w14,input(7),shift_certo,w15);
	u16: FlipFlopD port map (clock,w15,'1', '1',w16);
	u17: Mux2way port map (w16,input(8),shift_certo,w17);
	u18: FlipFlopD port map (clock,w17,'1', '1',w18);
	u19: Mux2way port map (w18,input(9),shift_certo,w19);
	u20: FlipFlopD port map (clock,w19,'1', '1',w20);
	u21: Mux2way port map (w20,input(10),shift_certo,w21);
	u22: FlipFlopD port map (clock,w21,'1', '1',w22);
	u23: Mux2way port map (w22,input(11),shift_certo,w23);
	u24: FlipFlopD port map (clock,w23,'1', '1',w24);
	u25: Mux2way port map (w24,input(12),shift_certo,w25);
	u26: FlipFlopD port map (clock,w25,'1', '1',w26);
	u27: Mux2way port map (w26,input(13),shift_certo,w27);
	u28: FlipFlopD port map (clock,w27,'1', '1',w28);
	u29: Mux2way port map (w28,input(14),shift_certo,w29);
	u30: FlipFlopD port map (clock,w29,'1', '1',w30);
	u31: Mux2way port map (w30,input(15),shift_certo,w31);
	u32: FlipFlopD port map (clock,w31,'1', '1',output);
end architecture;
