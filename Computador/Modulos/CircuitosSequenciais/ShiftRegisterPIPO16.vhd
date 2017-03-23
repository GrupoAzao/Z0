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

architecture Shift of ShiftRegisterPIPO16 is

component FlipFlopD is
	port(
		clock:  in std_logic;
		d:      in std_logic;
		clear:  in std_logic;
		preset: in std_logic;
		q:     out std_logic
	);
end component;

component Mux2Way is
	port (
			a:   in  STD_LOGIC;
			b:   in  STD_LOGIC;
			sel: in  STD_LOGIC;
			q:   out STD_LOGIC);
end component;

signal saida, saidaMuxes: STD_LOGIC_VECTOR(15 downto 0);
signal dir: STD_LOGIC;

begin

	dir <= not direction;

	FF0: FlipFlopD port map (clock,input(0),'1','1',saida(0));
	FF1: FlipFlopD port map (clock,input(1),'1','1',saida(1));
	FF2: FlipFlopD port map (clock,input(2),'1','1',saida(2));
	FF3: FlipFlopD port map (clock,input(3),'1','1',saida(3));
	FF4: FlipFlopD port map (clock,input(4),'1','1',saida(4));
	FF5: FlipFlopD port map (clock,input(5),'1','1',saida(5));
	FF6: FlipFlopD port map (clock,input(6),'1','1',saida(6));
   FF7: FlipFlopD port map (clock,input(7),'1','1',saida(7));
	FF8: FlipFlopD port map (clock,input(8),'1','1',saida(8));
	FF9: FlipFlopD port map (clock,input(9),'1','1',saida(9));
	FF10: FlipFlopD port map (clock,input(10),'1','1',saida(10));
	FF11: FlipFlopD port map (clock,input(11),'1','1',saida(11));
	FF12: FlipFlopD port map (clock,input(12),'1','1',saida(12));
   FF13: FlipFlopD port map (clock,input(13),'1','1',saida(13));
   FF14: FlipFlopD port map (clock,input(14),'1','1',saida(14));
	FF15: FlipFlopD port map (clock,input(15),'1','1',saida(15));
	
	Mux0: Mux2Way port map (saida(1),'0',dir,saidaMuxes(0));
	Mux1: Mux2Way port map (saida(2),saida(0),dir,saidaMuxes(1));
	Mux2: Mux2Way port map (saida(3),saida(1),dir,saidaMuxes(2));
	Mux3: Mux2Way port map (saida(4),saida(2),dir,saidaMuxes(3));
	Mux4: Mux2Way port map (saida(5),saida(3),dir,saidaMuxes(4));
	Mux5: Mux2Way port map (saida(6),saida(4),dir,saidaMuxes(5));
	Mux6: Mux2Way port map (saida(7),saida(5),dir,saidaMuxes(6));
	Mux7: Mux2Way port map (saida(8),saida(6),dir,saidaMuxes(7));
	Mux8: Mux2Way port map (saida(9),saida(7),dir,saidaMuxes(8));
	Mux9: Mux2Way port map (saida(10),saida(8),dir,saidaMuxes(9));
	Mux10: Mux2Way port map (saida(11),saida(9),dir,saidaMuxes(10));
	Mux11: Mux2Way port map (saida(12),saida(10),dir,saidaMuxes(11));
	Mux12: Mux2Way port map (saida(13),saida(11),dir,saidaMuxes(12));
	Mux13: Mux2Way port map (saida(14),saida(12),dir,saidaMuxes(13));
	Mux14: Mux2Way port map (saida(15),saida(13),dir,saidaMuxes(14));
	Mux15: Mux2Way port map ('0',saida(14),dir,saidaMuxes(15));

	output <= saidaMuxes;


end architecture;
