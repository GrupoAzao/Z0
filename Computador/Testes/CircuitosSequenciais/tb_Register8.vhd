-- Elementos de Sistemas
-- by Luciano Soares
-- tb_Register8.vhd

Library ieee; 
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_Register8 is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_Register8 is

	component Register8 is
		port(
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC_VECTOR(7 downto 0);
			load:    in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;

	signal inClock : std_logic := '0';
	signal inInput : STD_LOGIC_VECTOR(7 downto 0);
	signal inLoad : STD_LOGIC;
	signal outOutput : STD_LOGIC_VECTOR(7 downto 0);

begin 

	mapping: Register8 port map(inClock, inInput, inLoad, outOutput);

	inClock <= not inClock after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

		-- Teste: 0
		inInput <= "00000000"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "00000000")  report "Falha em teste: 0" severity error;

		-- Teste: 1
		inInput <= "00000000"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "00000000")  report "Falha em teste: 1" severity error;

		-- Teste: 2
		inInput <= "10000101"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "00000000")  report "Falha em teste: 2" severity error;

		-- Teste: 3
		inInput <= "01100111"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "00000000")  report "Falha em teste: 3" severity error;

		-- Teste: 4
		inInput <= "10000101"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "10000101")  report "Falha em teste: 4" severity error;

		-- Teste: 5
		inInput <= "10000101"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "10000101")  report "Falha em teste: 5" severity error;

		-- Teste: 6
		inInput <= "10000101"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "10000101")  report "Falha em teste: 6" severity error;

		-- Teste: 7
		inInput <= "00111001"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "00111001")  report "Falha em teste: 7" severity error;

		-- Teste: 8
		inInput <= "00000000"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "00111001")  report "Falha em teste: 8" severity error;

		-- Teste: 9
		inInput <= "00000000"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "00000000")  report "Falha em teste: 9" severity error;

		-- Teste: 10
		inInput <= "00000001"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "00000000")  report "Falha em teste: 10" severity error;

		-- Teste: 11
		inInput <= "00000001"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "00000001")  report "Falha em teste: 11" severity error;

		-- Teste: 12
		inInput <= "00000010"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "00000001")  report "Falha em teste: 12" severity error;

		-- Teste: 13
		inInput <= "00000010"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "00000010")  report "Falha em teste: 13" severity error;

		-- Teste: 14
		inInput <= "00000100"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "00000010")  report "Falha em teste: 14" severity error;

		-- Teste: 15
		inInput <= "00000100"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "00000100")  report "Falha em teste: 15" severity error;

		-- Teste: 16
		inInput <= "00001000"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "00000100")  report "Falha em teste: 16" severity error;

		-- Teste: 17
		inInput <= "00001000"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "00001000")  report "Falha em teste: 17" severity error;

		-- Teste: 18
		inInput <= "00010000"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "00001000")  report "Falha em teste: 18" severity error;

    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;