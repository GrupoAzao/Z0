-- Elementos de Sistemas
-- by Luciano Soares
-- tb_Ram8.vhd

Library ieee; 
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_Ram8 is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_Ram8 is

	component  Ram8 is
		port(
			clock:   in  STD_LOGIC;
			input:   in  STD_LOGIC_VECTOR(15 downto 0);
			load:    in  STD_LOGIC;
			address: in  STD_LOGIC_VECTOR( 2 downto 0);
			output:  out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	signal inClock : std_logic := '0';
	signal inInput : STD_LOGIC_VECTOR(15 downto 0);
	signal inLoad : STD_LOGIC;
	signal inAddress : STD_LOGIC_VECTOR( 2 downto 0);
	signal outOutput : STD_LOGIC_VECTOR(15 downto 0);

begin 

	mapping: Ram8 port map(inClock, inInput, inLoad, inAddress, outOutput);

	inClock <= not inClock after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

		-- Teste: 0
		inInput <= "0000000000000000"; inAddress <= "000"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "0000000000000000")  report "Falha em teste: 0" severity error;

		-- Teste: 1
		inInput <= "0000000000000000"; inAddress <= "000"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "0000000000000000")  report "Falha em teste: 0" severity error;

		-- Teste: 2
		inInput <= "0010101101100111"; inAddress <= "000"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "0000000000000000")  report "Falha em teste: 0" severity error;

		-- Teste: 3
		inInput <= "0010101101100111"; inAddress <= "001"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "0010101101100111")  report "Falha em teste: 0" severity error;

		-- Teste: 4
		inInput <= "0010101101100111"; inAddress <= "000"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "0000000000000000")  report "Falha em teste: 0" severity error;

		-- Teste: 5
		inInput <= "0000110100000101"; inAddress <= "011"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "0000110100000101")  report "Falha em teste: 0" severity error;

		-- Teste: 6
		inInput <= "0000110100000101"; inAddress <= "011"; inLoad <= '1'; 
		wait for 200 ps;
		assert(outOutput = "0000110100000101")  report "Falha em teste: 0" severity error;

		-- Teste: 7
		inInput <= "0000110100000101"; inAddress <= "011"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "0000110100000101")  report "Falha em teste: 0" severity error;

		-- Teste: 8
		inInput <= "0001111001100001"; inAddress <= "001"; inLoad <= '0'; 
		wait for 200 ps;
		assert(outOutput = "0010101101100111")  report "Falha em teste: 0" severity error;

    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;