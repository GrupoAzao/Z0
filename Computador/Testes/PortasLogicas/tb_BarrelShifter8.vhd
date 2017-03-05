library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_BarrelShifter8 is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_BarrelShifter8 is

	component BarrelShifter8 is
	port ( 
			a:    in  STD_LOGIC_VECTOR(7 downto 0);   -- input vector
			dir:  in  STD_LOGIC;                       -- 0=>left 1=>right
			size: in  STD_LOGIC_VECTOR(2 downto 0);    -- shift amount
			q:    out STD_LOGIC_VECTOR(7 downto 0));  -- output vector (shifted)
	end component;

	signal  inA, outQ : STD_LOGIC_VECTOR(7 downto 0);
	signal  inDir : STD_LOGIC;
	signal  inSize : STD_LOGIC_VECTOR(2 downto 0);

begin
	mapping: BarrelShifter8 port map(inA, inDir, inSize, outQ);

	main : process
	begin
	test_runner_setup(runner, runner_cfg);

	-- Teste: 1
	inA <= "00000010"; inDir <='0'; inSize <= "000";
	wait for 200 ps;
	assert(outQ = "00000010")  report "Falha em teste: 1" severity error;

	-- Teste: 2
	inA <= "00000010"; inDir <='0'; inSize <= "001";
	wait for 200 ps;
	assert(outQ = "00000100")  report "Falha em teste: 2" severity error;

	-- Teste: 3
	inA <= "00000010"; inDir <='0'; inSize <= "010";
	wait for 200 ps;
	assert(outQ = "00001000")  report "Falha em teste: 3" severity error;

	-- Teste: 4
	inA <= "00000010"; inDir <='0'; inSize <= "011";
	wait for 200 ps;
	assert(outQ = "00010000")  report "Falha em teste: 4" severity error;

	-- Teste: 5
	inA <= "00000010"; inDir <='0'; inSize <= "100";
	wait for 200 ps;
	assert(outQ = "00100000")  report "Falha em teste: 5" severity error;

	-- Teste: 6
	inA <= "01000000"; inDir <='1'; inSize <= "000";
	wait for 200 ps;
	assert(outQ = "01000000")  report "Falha em teste: 6" severity error;

	-- Teste: 7
	inA <= "01000000"; inDir <='1'; inSize <= "001";
	wait for 200 ps;
	assert(outQ = "00100000")  report "Falha em teste: 7" severity error;

	-- Teste: 8
	inA <= "01000000"; inDir <='1'; inSize <= "010";
	wait for 200 ps;
	assert(outQ = "00010000")  report "Falha em teste: 8" severity error;

	-- Teste: 9
	inA <= "01000000"; inDir <='1'; inSize <= "011";
	wait for 200 ps;
	assert(outQ = "00001000")  report "Falha em teste: 9" severity error;

	-- Teste: 10
	inA <= "01000000"; inDir <='1'; inSize <= "100";
	wait for 200 ps;
	assert(outQ = "00000100")  report "Falha em teste: 10" severity error;




	test_runner_cleanup(runner); -- Simulacao acaba aqui

  end process;
end architecture;