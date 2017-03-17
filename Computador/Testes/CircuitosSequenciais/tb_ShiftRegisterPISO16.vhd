-- Elementos de Sistemas
-- by Luciano Soares
-- tb_ShiftRegisterPISO16.vhd

Library ieee; 
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ShiftRegisterPISO16 is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ShiftRegisterPISO16 is

	component ShiftRegisterPISO16 is
		port(
			clock:   in STD_LOGIC;
			input:   in STD_LOGIC_VECTOR(15 downto 0);
			shift:   in STD_LOGIC;
			output:  out STD_LOGIC
		);
	end component;

	signal inClock   : std_logic := '0';
	signal inInput   : STD_LOGIC_VECTOR(15 downto 0);
	signal inShift   : STD_LOGIC;
	signal outOutput : STD_LOGIC;

begin 

	mapping: ShiftRegisterPISO16 port map(inClock, inInput, inShift, outOutput);

	inClock <= not inClock after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

		-- Teste: 0
		inInput <= "0000000000000000"; inShift <= '0'; 
		wait for 200 ps;
		assert(outOutput = '0')  report "Falha em teste: 0" severity error;
		
		-- Teste: 1
		inInput <= "0000000000000000"; inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 1" severity error;

		-- Teste: 2
		inInput <= "1010101010101010"; inShift <= '0'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '1')  report "Falha em teste: 2" severity error;

		-- Teste: 3
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 3" severity error;

		-- Teste: 4
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '1')  report "Falha em teste: 4" severity error;

		-- Teste: 5
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 5" severity error;

		-- Teste: 6
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '1')  report "Falha em teste: 6" severity error;

		-- Teste: 7
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 7" severity error;

		-- Teste: 8
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '1')  report "Falha em teste: 8" severity error;

		-- Teste: 9
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 9" severity error;

		-- Teste: 10
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '1')  report "Falha em teste: 10" severity error;

		-- Teste: 11
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 11" severity error;

		-- Teste: 12
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '1')  report "Falha em teste: 12" severity error;

		-- Teste: 13
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 13" severity error;

		-- Teste: 14
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '1')  report "Falha em teste: 14" severity error;

		-- Teste: 15
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 15" severity error;

		-- Teste: 16
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '1')  report "Falha em teste: 16" severity error;

		-- Teste: 17
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 17" severity error;

		-- Teste: 18
		inInput <= "0000000000000001"; inShift <= '0'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 18" severity error;

		-- Teste: 19
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 19" severity error;

		-- Teste: 20
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 20" severity error;

		-- Teste: 21
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 21" severity error;

		-- Teste: 22
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 22" severity error;

		-- Teste: 23
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 23" severity error;

		-- Teste: 24
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 24" severity error;

		-- Teste: 25
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 25" severity error;

		-- Teste: 26
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 26" severity error;

		-- Teste: 27
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 27" severity error;

		-- Teste: 28
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 28" severity error;

		-- Teste: 29
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 29" severity error;

		-- Teste: 30
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 30" severity error;

		-- Teste: 31
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 31" severity error;

		-- Teste: 32
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '0')  report "Falha em teste: 32" severity error;

		-- Teste: 33
		inShift <= '1'; 
		wait for 200 ps; -- precisa de mais tempo para garantir sinais internos
		assert(outOutput = '1')  report "Falha em teste: 33" severity error;

    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;