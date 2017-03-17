-- Elementos de Sistemas
-- by Luciano Soares
-- tb_ShiftRegisterSIPO16.vhd

Library ieee; 
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ShiftRegisterSIPO16 is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ShiftRegisterSIPO16 is

	component ShiftRegisterSIPO16 is
		port(
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	signal inClock   : STD_LOGIC := '0';
	signal inInput   : STD_LOGIC;
	signal outOutput : STD_LOGIC_VECTOR(15 downto 0);

begin 

	mapping: ShiftRegisterSIPO16 port map(inClock, inInput, outOutput);

	inClock <= not inClock after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

		-- Teste: 0
		inInput <= '0';
		wait for 3200 ps;
		assert(outOutput = "0000000000000000")  report "Falha em teste: 0" severity error;

		-- Teste: 1
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1000000000000000")  report "Falha em teste: 1" severity error;

		-- Teste: 2
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1100000000000000")  report "Falha em teste: 2" severity error;

		-- Teste: 3
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1110000000000000")  report "Falha em teste: 3" severity error;

		-- Teste: 4
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = "0111000000000000")  report "Falha em teste: 4" severity error;

		-- Teste: 5
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = "0011100000000000")  report "Falha em teste: 5" severity error;

		-- Teste: 6
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = "0001110000000000")  report "Falha em teste: 6" severity error;

		-- Teste: 7
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1000111000000000")  report "Falha em teste: 7" severity error;

		-- Teste: 8
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = "0100011100000000")  report "Falha em teste: 8" severity error;

		-- Teste: 9
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1010001110000000")  report "Falha em teste: 9" severity error;

		-- Teste: 10
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1101000111000000")  report "Falha em teste: 10" severity error;

		-- Teste: 11
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1110100011100000")  report "Falha em teste: 11" severity error;

		-- Teste: 12
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1111010001110000")  report "Falha em teste: 12" severity error;

		-- Teste: 13
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1111101000111000")  report "Falha em teste: 13" severity error;

		-- Teste: 14
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1111110100011100")  report "Falha em teste: 14" severity error;

		-- Teste: 15
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1111111010001110")  report "Falha em teste: 15" severity error;

		-- Teste: 16
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = "1111111101000111")  report "Falha em teste: 16" severity error;

    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;