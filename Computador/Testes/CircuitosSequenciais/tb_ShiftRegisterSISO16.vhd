-- Elementos de Sistemas
-- by Luciano Soares
-- tb_ShiftRegisterSISO16.vhd

Library ieee; 
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ShiftRegisterSISO16 is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ShiftRegisterSISO16 is

	component ShiftRegisterSISO16 is
		port(
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC;
			output: out STD_LOGIC
		);
	end component;

	signal inClock   : STD_LOGIC := '0';
	signal inInput   : STD_LOGIC;
	signal outOutput : STD_LOGIC;

begin 

	mapping: ShiftRegisterSISO16 port map(inClock, inInput, outOutput);

	inClock <= not inClock after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

		-- Teste: 0
		inInput <= '0';
		wait for 3200 ps;
		assert(outOutput = '0')  report "Falha em teste: 0" severity error;

		-- Teste: 1
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 1" severity error;

		-- Teste: 2
		inInput <= '1';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 2" severity error;

		-- Teste: 3
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 3" severity error;

		-- Teste: 4
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 4" severity error;

		-- Teste: 5
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 5" severity error;

		-- Teste: 6
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 6" severity error;

		-- Teste: 7
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 7" severity error;

		-- Teste: 8
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 8" severity error;

		-- Teste: 9
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 9" severity error;

		-- Teste: 10
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 10" severity error;

		-- Teste: 11
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 11" severity error;

		-- Teste: 12
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 12" severity error;

		-- Teste: 13
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 13" severity error;

		-- Teste: 14
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 14" severity error;

		-- Teste: 15
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 15" severity error;

		-- Teste: 16
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 16" severity error;

		-- Teste: 17
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 16" severity error;

		-- Teste: 18
		inInput <= '0';
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 16" severity error;

    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;