-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: tb_CPU.vhd
-- date: 4/4/2017

-- Unidade Central de Processamento

library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_CPU is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_CPU is

  component CPU is
    port(
        clock:       in  STD_LOGIC;
        inM:         in  STD_LOGIC_VECTOR(15 downto 0);
        instruction: in  STD_LOGIC_VECTOR(15 downto 0);
        reset:       in  STD_LOGIC;
        outM:        out STD_LOGIC_VECTOR(15 downto 0);
        writeM:      out STD_LOGIC;
        addressM:    out STD_LOGIC_VECTOR(14 downto 0);
        pcout:       out STD_LOGIC_VECTOR(14 downto 0)
    );
  end component;

      signal inClock : STD_LOGIC := '0';
      signal inInM : STD_LOGIC_VECTOR(15 downto 0);
      signal inInstruction : STD_LOGIC_VECTOR(15 downto 0);
      signal inReset : STD_LOGIC;
      signal outOutM : STD_LOGIC_VECTOR(15 downto 0);
      signal outWriteM : STD_LOGIC;
      signal outAddressM : STD_LOGIC_VECTOR(14 downto 0);
      signal outPcout : STD_LOGIC_VECTOR(14 downto 0);

begin

      mapping: CPU port map(inClock, inInM, inInstruction, inReset, outOutM, outWriteM, outAddressM, outPcout );

      inClock <= not inClock after 100 ps;

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

      -- Teste: 0 - leaw $12345,%A
      inInM <= "0000000000000000"; inInstruction <= "0011000000111001"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="011000000111001" and outPcout="000000000000001")
       report "Falha em teste: 0" severity error;

      -- Teste: 1 - movw %A,%D
      inInM <= "0000000000000000"; inInstruction <= "1110110000010000"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="011000000111001" and outPcout="000000000000010")
       report "Falha em teste: 1" severity error;

      -- Teste: 2 - leaw $23456,%A
      inInM <= "0000000000000000"; inInstruction <= "0101101110100000"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="101101110100000" and outPcout="000000000000011")
       report "Falha em teste: 2" severity error;

      -- Teste: 3 - subw %A,%D,%D
      inInM <= "0000000000000000"; inInstruction <= "1110000111010000"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="101101110100000" and outPcout="000000000000100")
       report "Falha em teste: 3" severity error;

      -- Teste: 4 - leaw $1000,%A
      inInM <= "0000000000000000"; inInstruction <= "0000001111101000"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="000001111101000" and outPcout="000000000000101")
       report "Falha em teste: 4" severity error;

      -- Teste: 5 - movw %D,(%A) 
      inInM <= "0000000000000000"; inInstruction <= "1110001100001000"; inReset <= '0';
      wait for 200 ps;
      assert(outOutM="0010101101100111" and outWriteM='1' and outAddressM="000001111101000" and outPcout="000000000000110")
       report "Falha em teste: 5" severity error;

      -- Teste: 6 - leaw $1001,%A
      inInM <= "0000000000000000"; inInstruction <= "0000001111101001"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="000001111101001" and outPcout="000000000000111")
       report "Falha em teste: 6" severity error;

      -- Teste: 7 - dec %D
      inInM <= "0000000000000000"; inInstruction <= "1110001110010000"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="000001111101001" and outPcout="000000000001000")
       report "Falha em teste: 7" severity error;

      -- Teste: 8 - movw %D,(%A)
      inInM <= "0000000000000000"; inInstruction <= "1110001100001000"; inReset <= '0';
      wait for 200 ps;
      assert(outOutM="0010101101100110" and outWriteM='1' and outAddressM="000001111101001" and outPcout="000000000001001")
       report "Falha em teste: 8" severity error;

      -- Teste: 9 - leaw $1000,%A
      inInM <= "0000000000000000"; inInstruction <= "0000001111101000"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="000001111101000" and outPcout="000000000001010")
       report "Falha em teste: 9" severity error;

      -- Teste: 10 - subw %D,(%A),%D
      inInM <= "0010101101100111"; inInstruction <= "1111010011010000"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="000001111101000" and outPcout="000000000001011")
       report "Falha em teste: 10" severity error;

      -- Teste: 11 - leaw $16,%A
      inInM <= "0010101101100111"; inInstruction <= "0000000000001110"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="000000000001110" and outPcout="000000000001100")
       report "Falha em teste: 11" severity error;

      -- Teste: 12 - jl
      inInM <= "0010101101100111"; inInstruction <= "1110001100000100"; inReset <= '0';
      wait for 200 ps;
      assert(outWriteM='0' and outAddressM="000000000001110" and outPcout="000000000001110")
       report "Falha em teste: 12 ("&std_logic'image(outPcout(14))&std_logic'image(outPcout(13))&std_logic'image(outPcout(12))&std_logic'image(outPcout(11))&std_logic'image(outPcout(10))&std_logic'image(outPcout(9))&std_logic'image(outPcout(8))&std_logic'image(outPcout(7))&std_logic'image(outPcout(6))&std_logic'image(outPcout(5))&std_logic'image(outPcout(4))&std_logic'image(outPcout(3))&std_logic'image(outPcout(2))&std_logic'image(outPcout(1))&std_logic'image(outPcout(0))  severity error;


    test_runner_cleanup(runner); -- Simulacao acaba aqui

  end process;
end architecture;