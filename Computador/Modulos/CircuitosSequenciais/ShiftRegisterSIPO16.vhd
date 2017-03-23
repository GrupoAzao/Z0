
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



architecture arch_ShiftRegisterSIPO16 of ShiftRegisterSIPO16 is



signal w: STD_LOGIC_VECTOR(15 downto 0);



component FlipFlopD is

	port(

			clock:  in std_logic;

			d:      in std_logic;

			clear:  in std_logic;

			preset: in std_logic;

			q:     out std_logic

		);

end component;



begin 

	u1: FlipFlopD port map (clock, input, '1', '1', w(15));

	u2: FlipFlopD port map (clock, w(15), '1', '1',  w(14));

	u3: FlipFlopD port map (clock, w(14), '1', '1',  w(13));

	u4: FlipFlopD port map (clock, w(13), '1', '1',  w(12));

	u5: FlipFlopD port map (clock, w(12), '1', '1',  w(11));

	u6: FlipFlopD port map (clock, w(11), '1', '1',  w(10));

	u7: FlipFlopD port map (clock, w(10), '1', '1',  w(9));

	u8: FlipFlopD port map (clock, w(9), '1', '1',  w(8));

	u9: FlipFlopD port map (clock, w(8), '1', '1',  w(7));

	u10: FlipFlopD port map (clock, w(7), '1', '1',  w(6));

	u11: FlipFlopD port map (clock, w(6), '1', '1',  w(5));

	u12: FlipFlopD port map (clock, w(5), '1', '1',  w(4));

	u13: FlipFlopD port map (clock, w(4), '1', '1',  w(3));

	u14: FlipFlopD port map (clock, w(3), '1', '1',  w(2));

	u15: FlipFlopD port map (clock, w(2), '1', '1',  w(1));

	u16: FlipFlopD port map (clock, w(1), '1', '1',  w(0));



	output <= w;

	

end architecture;
