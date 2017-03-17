-- Elementos de Sistemas
-- by Luciano Soares
-- tb_ShiftRegisterPIPO16.vhd

Library ieee; 
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ShiftRegisterPIPO16 is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ShiftRegisterPIPO16 is

	component ShiftRegisterPIPO16 is
		port(
			clock:     in  STD_LOGIC;
			input:     in  STD_LOGIC_VECTOR(15 downto 0);
			direction: in  STD_LOGIC;
			output:    out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	signal inClock     : std_logic := '0';
	signal inInput     : STD_LOGIC_VECTOR(15 downto 0);
	signal inDirection : STD_LOGIC;
	signal outOutput   : STD_LOGIC_VECTOR(15 downto 0);

begin 

	mapping: ShiftRegisterPIPO16 port map(inClock, inInput, inDirection, outOutput);

	inClock <= not inClock after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);


		-- Teste: 0
		inInput <= "0000000000000000"; inDirection <= '0'; 
		wait for 200 ps;
		assert(outOutput = "0000000000000000")  report "Falha em teste: 0" severity error;

		-- Teste: 1
		inInput <= "0000000000000100"; inDirection <= '0'; 
		wait for 200 ps;
		assert(outOutput = "0000000000001000")  report "Falha em teste: 1" severity error;

		-- Teste: 2
		inInput <= "0000000000000100"; inDirection <= '1'; 
		wait for 200 ps;
		assert(outOutput = "0000000000000010")  report "Falha em teste: 2" severity error;

		-- Teste: 3
		inInput <= "0101010101010101"; inDirection <= '0'; 
		wait for 200 ps;
		assert(outOutput = "1010101010101010")  report "Falha em teste: 3" severity error;

		-- Teste: 4
		inInput <= "1010101010101010"; inDirection <= '1'; 
		wait for 200 ps;
		assert(outOutput = "0101010101010101")  report "Falha em teste: 4" severity error;

		-- Teste: 5
		inInput <= "1010101010101010"; inDirection <= '0'; 
		wait for 200 ps;
		assert(outOutput = "0101010101010100")  report "Falha em teste: 5" severity error;

		-- Teste: 6
		inInput <= "0101010101010101"; inDirection <= '1'; 
		wait for 200 ps;
		assert(outOutput = "0010101010101010")  report "Falha em teste: 6" severity error;



    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;