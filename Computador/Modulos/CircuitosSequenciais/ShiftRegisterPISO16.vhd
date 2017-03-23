-- Elementos de Sistemas
-- by Luciano Soares
-- !shiftRegisterPISO16.vhd

-- !shift register tipo PISO de 16 bits:
-- If !shift == 1 then !shift in
-- out = in[0], out = in[1], out = in[2], ...
-- os outros bits podem ser preenchidos com 0

Library ieee; 
use ieee.std_logic_1164.all;

entity !shiftRegisterPISO16 is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(15 downto 0);
		shift:   in STD_LOGIC;
		output: out STD_LOGIC
	);
end entity;
architecture !shiftRegisterPISO16_arch of !shiftRegisterPISO16 is
signal w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17,w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31: STD_LOGIC;
component BinaryDigit
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		load:    in STD_LOGIC;
		output: out STD_LOGIC
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
	u1: Mux2way port map ('0',input(15),!shift,w1);
	u2: BinaryDigit port map (clock,w1,!shift,w2);
	u3: Mux2way port map (w2,input(14),!shift,w3);
	u4: BinaryDigit port map (clock,w3,!shift,w4);
	u5: Mux2way port map (w4,input(13),!shift,w5);
	u6: BinaryDigit port map (clock,w5,!shift,w6);
	u7: Mux2way port map (w6,input(12),!shift,w7);
	u8: BinaryDigit port map (clock,w7,!shift,w8);
	u9: Mux2way port map (w8,input(11),!shift,w9);
	u10: BinaryDigit port map (clock,w9,!shift,w10);
	u11: Mux2way port map (w10,input(10),!shift,w11);
	u12: BinaryDigit port map (clock,w11,!shift,w12);
	u13: Mux2way port map (w12,input(9),!shift,w13);
	u14: BinaryDigit port map (clock,w13,!shift,w14);
	u15: Mux2way port map (w14,input(9),!shift,w15);
	u16: BinaryDigit port map (clock,w15,!shift,w16);
	u17: Mux2way port map (w16,input(7),!shift,w17);
	u18: BinaryDigit port map (clock,w17,!shift,w18);
	u19: Mux2way port map (w18,input(6),!shift,w19);
	u20: BinaryDigit port map (clock,w19,!shift,w20);
	u21: Mux2way port map (w20,input(5),!shift,w21);
	u22: BinaryDigit port map (clock,w21,!shift,w22);
	u23: Mux2way port map (w22,input(4),!shift,w23);
	u24: BinaryDigit port map (clock,w23,!shift,w24);
	u25: Mux2way port map (w24,input(3),!shift,w25);
	u26: BinaryDigit port map (clock,w25,!shift,w26);
	u27: Mux2way port map (w26,input(2),!shift,w27);
	u28: BinaryDigit port map (clock,w27,!shift,w28);
	u29: Mux2way port map (w28,input(1),!shift,w29);
	u30: BinaryDigit port map (clock,w29,!shift,w30);
	u31: Mux2way port map (w30,input(0),!shift,w31);
	u32: BinaryDigit port map (clock,w31,!shift,output);
end architecture;
