-- Elementos de Sistemas
-- developed by Luciano Soares
-- tb_BinaryDigit.vhd
-- date: 4/4/2017

Library ieee; 
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_BinaryDigit is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_BinaryDigit is

	component BinaryDigit is
		port(
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC;
			load:    in STD_LOGIC;
			output: out STD_LOGIC
		);
	end component;

	signal inClock : std_logic := '0';
	signal inInput, inLoad, outOutput : std_logic;

begin 

	mapping: BinaryDigit port map(inClock, inInput, inLoad, outOutput);

	inClock <= not inClock after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

		-- Teste: 0
		inInput <= '0'; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 0" severity error;

		-- Teste: 1
		inInput <= '0'; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 1" severity error;

		-- Teste: 2
		inInput <= '1'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 2" severity error;

		-- Teste: 3
		inInput <= '1'; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 3" severity error;

		-- Teste: 4
		inInput <= '0'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 4" severity error;

		-- Teste: 5
		inInput <= '1'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 5" severity error;

		-- Teste: 6
		inInput <= '0'; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 6" severity error;

		-- Teste: 7
		inInput <= '1'; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 7" severity error;

		-- Teste: 8
		inInput <= '0'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 8" severity error;

		-- Teste: 9
		inInput <= '0'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 9" severity error;

		-- Teste: 10
		inInput <= '0'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 10" severity error;

		-- Teste: 11
		inInput <= '0'; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 11" severity error;

		-- Teste: 12
		inInput <= '1'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 12" severity error;

		-- Teste: 13
		inInput <= '1'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 13" severity error;

		-- Teste: 14
		inInput <= '1'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 14" severity error;

		-- Teste: 15    -- para testar se valor esta de fato ficando armazenado no flip-flop
		inInput <= '1'; inLoad <= '1'; 
		wait for 50 ps;
		assert(outOutput = '0')  report "Falha em teste: 15" severity error;

		-- Teste: 16    -- para testar se valor esta de fato ficando armazenado no flip-flop
		inInput <= '1'; inLoad <= '1'; 
		wait for 150 ps;
		assert(outOutput = '1')  report "Falha em teste: 16" severity error;

		-- Teste: 17    -- para testar se valor esta de fato ficando armazenado no flip-flop
		inInput <= '1'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '1')  report "Falha em teste: 17" severity error;

		-- Teste: 18    -- para testar se valor esta de fato ficando armazenado no flip-flop
		inInput <= '0'; inLoad <= '1'; 
		wait for 50 ps;
		assert(outOutput = '1')  report "Falha em teste: 18" severity error;

		-- Teste: 19    -- para testar se valor esta de fato ficando armazenado no flip-flop
		inInput <= '0'; inLoad <= '1'; 
		wait for 150 ps;
		assert(outOutput = '0')  report "Falha em teste: 19" severity error;

		-- Teste: 20
		inInput <= '1'; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 20" severity error;


    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;