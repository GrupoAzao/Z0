-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: tb_PC.vhd
-- date: 4/4/2017

library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_PC is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_PC is

component PC is
    port(
        clock     : in  STD_LOGIC;
        increment : in  STD_LOGIC;
        load      : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        input     : in  std_logic_vector(15 downto 0);
        output    : out std_logic_vector(14 downto 0)
    );
end component;

      signal  inClock : STD_LOGIC := '0';
      signal  inIncrement, inLoad, inReset : STD_LOGIC;
      signal  inInput : STD_LOGIC_VECTOR(15 downto 0);
      signal  outOutput : STD_LOGIC_VECTOR(14 downto 0);

begin

      mapping: PC port map(inClock, inIncrement, inLoad, inReset, inInput, outOutput);

      inClock <= not inClock after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

      -- Teste: 0
      inIncrement <= '0'; inLoad <= '0'; inReset <= '1'; inInput <= "0000000000000000";
      wait for 400 ps;
      assert(outOutput = "000000000000000")  report "Falha em teste: 0" severity error;

      -- Teste: 1
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000000000";
      wait for 200 ps;
      assert(outOutput = "000000000000001")  report "Falha em teste: 1" severity error;

      -- Teste: 2
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000000000";
      wait for 200 ps;
      assert(outOutput = "000000000000010")  report "Falha em teste: 2" severity error;

      -- Teste: 3
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000000000";
      wait for 200 ps;
      assert(outOutput = "000000000000011")  report "Falha em teste: 3" severity error;

      -- Teste: 4
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000000000";
      wait for 200 ps;
      assert(outOutput = "000000000000100")  report "Falha em teste: 4" severity error;

      -- Teste: 5
      inIncrement <= '0'; inLoad <= '0'; inReset <= '1'; inInput <= "0000000000000000";
      wait for 200 ps;
      assert(outOutput = "000000000000000")  report "Falha em teste: 5" severity error;

      -- Teste: 6
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000000000";
      wait for 200 ps;
      assert(outOutput = "000000000000001")  report "Falha em teste: 6" severity error;

      -- Teste: 7
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000000000";
      wait for 200 ps;
      assert(outOutput = "000000000000010")  report "Falha em teste: 7" severity error;

      -- Teste: 8
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000000000";
      wait for 200 ps;
      assert(outOutput = "000000000000011")  report "Falha em teste: 8" severity error;

      -- Teste: 9
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000000000";
      wait for 200 ps;
      assert(outOutput = "000000000000100")  report "Falha em teste: 9" severity error;

      -- Teste: 10
      inIncrement <= '0'; inLoad <= '1'; inReset <= '0'; inInput <= "0000000000010000";
      wait for 200 ps;
      assert(outOutput = "000000000010000")  report "Falha em teste: 10" severity error;

      -- Teste: 11
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000010000";
      wait for 200 ps;
      assert(outOutput = "000000000010001")  report "Falha em teste: 11" severity error;

      -- Teste: 12
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000010000";
      wait for 200 ps;
      assert(outOutput = "000000000010010")  report "Falha em teste: 12" severity error;

      -- Teste: 13
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0000000000010000";
      wait for 200 ps;
      assert(outOutput = "000000000010011")  report "Falha em teste: 13" severity error;

      -- Teste: 14
      inIncrement <= '1'; inLoad <= '1'; inReset <= '0'; inInput <= "0011111111111111";
      wait for 200 ps;
      assert(outOutput = "011111111111111")  report "Falha em teste: 14" severity error;

      -- Teste: 15
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0011111111111111";
      wait for 200 ps;
      assert(outOutput = "100000000000000")  report "Falha em teste: 15" severity error;

      -- Teste: 16
      inIncrement <= '1'; inLoad <= '0'; inReset <= '0'; inInput <= "0011111111111111";
      wait for 200 ps;
      assert(outOutput = "100000000000001")  report "Falha em teste: 16" severity error;

      -- Teste: 17
      inIncrement <= '1'; inLoad <= '0'; inReset <= '1'; inInput <= "0011111111111111";
      wait for 200 ps;
      assert(outOutput = "000000000000000")  report "Falha em teste: 17" severity error;

      -- Teste: 18
      inIncrement <= '1'; inLoad <= '0'; inReset <= '1'; inInput <= "0011111111111111";
      wait for 200 ps;
      assert(outOutput = "000000000000000")  report "Falha em teste: 18" severity error;

    test_runner_cleanup(runner); -- Simulacao acaba aqui

  end process;
end architecture;