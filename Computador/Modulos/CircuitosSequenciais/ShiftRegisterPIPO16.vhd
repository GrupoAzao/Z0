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

component BarrelShifter16 is
	port (
			a:    in  STD_LOGIC_VECTOR(15 downto 0);   -- input vector
			dir:  in  std_logic;                       -- 0=>left 1=>right
			size: in  std_logic_vector(2 downto 0);    -- shift amount
			q:    out STD_LOGIC_VECTOR(15 downto 0));  -- output vector (shifted)
end component;

signal saida, saidaShifter: STD_LOGIC_VECTOR(15 downto 0);

begin

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

	outShifter: BarrelShifter16 port map (saida, direction, "001", saidaShifter);

process (direction,saidaShifter) begin

	if(direction = '0') then
		saidaShifter(15) <= '0';
	else
		saidaShifter(0) <= '0';
	end if;

	output <= saidaShifter;

end process;
end architecture;
