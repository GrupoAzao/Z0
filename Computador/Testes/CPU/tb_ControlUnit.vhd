-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: tb_ControlUnit.vhd
-- date: 4/4/2017

-- Teste da Unidade de Controle

library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ControlUnity is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ControlUnity is

  component ControlUnit is
    port(
      instruction                 : in STD_LOGIC_VECTOR(15 downto 0);  -- instrução para executar
      zr,ng                       : in STD_LOGIC;                      -- valores zr(se zero) e ng(se negativo) da ALU
      muxALUI_A                   : out STD_LOGIC;                     -- mux que seleciona entre instrução e ALU para reg. A
      muxAM_ALU                   : out STD_LOGIC;                     -- mux que seleciona entre reg. A e Mem. RAM para ALU
      zx, nx, zy, ny, f, no       : out STD_LOGIC;                     -- sinais de controle da ALU
      loadA, loadD, loadM, loadPC : out STD_LOGIC                      -- sinais de load do reg. A, reg. D, Mem. RAM e Program Counter
    );
  end component;

      signal inInstruction : STD_LOGIC_VECTOR(15 downto 0);
      signal inZr, inNg : STD_LOGIC;
      signal outMuxALUI_A : STD_LOGIC;
      signal outMuxAM_ALU : STD_LOGIC;
      signal outZx, outNx, outZy, outNy, outF, outNo : STD_LOGIC;
      signal outLoadA, outLoadD, outLoadM, outLoadPC : STD_LOGIC;

begin

      mapping: ControlUnit port map(inInstruction, inZr, inNg, outMuxALUI_A, outMuxAM_ALU, outZx, outNx, outZy, outNy, outF, outNo, outLoadA, outLoadD, outLoadM, outLoadPC);

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

      -- Teste: 0 - leaw $0,%A  
      inInstruction <= "0000000000000000"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outMuxALUI_A='1' and outLoadA='1' and outLoadPC='0')  report "Falha em teste: 0" severity error;

      -- Teste: 1 - leaw $15,%A
      inInstruction <= "0111111111111111"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outMuxALUI_A='1' and outLoadA='1' and outLoadPC='0')  report "Falha em teste: 1" severity error;

      -- Teste: 2 - movw (%A),%D 
      inInstruction <= "1111110000010000"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outMuxAM_ALU='1' and outLoadA='0' and outLoadD='1' and outLoadM='0' and outLoadPC='0')  report "Falha em teste: 2" severity error;
    
      -- Teste: 3 - addw (%A), %D, %D
      inInstruction <= "1111000010010000"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outMuxAM_ALU='1' and outZx='0' and outNx='0' and outZy='0' and outNy='0' and outF='1' and outNo='0' and 
      outLoadA='0' and outLoadD='1' and outLoadM='0' and outLoadPC='0')  report "Falha em teste: 3" severity error;

      -- Teste: 4 - jmp
      inInstruction <= "1110001100000111"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadA='0' and outLoadD='0' and outLoadM='0' and outLoadPC='1')  report "Falha em teste: 4" severity error;

      -- Teste: 5 - je (com D==0)
      inInstruction <= "1110001100000010"; inZr <= '1'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='1')  report "Falha em teste: 5" severity error;

      -- Teste: 6 - je (com D>0)
      inInstruction <= "1110001100000010"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='0')  report "Falha em teste: 6" severity error;

      -- Teste: 7 - je (com D<0)
      inInstruction <= "1110001100000010"; inZr <= '0'; inNg <= '1'; 
      wait for 200 ps;
      assert(outLoadPC='0')  report "Falha em teste: 7" severity error;

      -- Teste: 8 - jne (com D==0)
      inInstruction <= "1110001100000101"; inZr <= '1'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='0')  report "Falha em teste: 8" severity error;

      -- Teste: 9 - jne (com D>0)
      inInstruction <= "1110001100000101"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='1')  report "Falha em teste: 9" severity error;

      -- Teste: 10 - jne (com D<0)
      inInstruction <= "1110001100000101"; inZr <= '0'; inNg <= '1'; 
      wait for 200 ps;
      assert(outLoadPC='1')  report "Falha em teste: 10" severity error;

      -- Teste: 11 - jg (com D==0)
      inInstruction <= "1110001100000001"; inZr <= '1'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='0')  report "Falha em teste: 11" severity error;

      -- Teste: 12 - jg (com D>0)
      inInstruction <= "1110001100000001"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='1')  report "Falha em teste: 12" severity error;

      -- Teste: 13 - jg (com D<0)
      inInstruction <= "1110001100000001"; inZr <= '0'; inNg <= '1'; 
      wait for 200 ps;
      assert(outLoadPC='0')  report "Falha em teste: 13" severity error;

      -- Teste: 14 - jge (com D==0)
      inInstruction <= "1110001100000011"; inZr <= '1'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='1')  report "Falha em teste: 14" severity error;

      -- Teste: 15 - jge (com D>0)
      inInstruction <= "1110001100000011"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='1')  report "Falha em teste: 15" severity error;

      -- Teste: 16 - jge (com D<0)
      inInstruction <= "1110001100000011"; inZr <= '0'; inNg <= '1'; 
      wait for 200 ps;
      assert(outLoadPC='0')  report "Falha em teste: 16" severity error;

      -- Teste: 17 - jl (com D==0)
      inInstruction <= "1110001100000100"; inZr <= '1'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='0')  report "Falha em teste: 17" severity error;

      -- Teste: 18 - jl (com D>0)
      inInstruction <= "1110001100000100"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='0')  report "Falha em teste: 18" severity error;

      -- Teste: 19 - jl (com D<0)
      inInstruction <= "1110001100000100"; inZr <= '0'; inNg <= '1'; 
      wait for 200 ps;
      assert(outLoadPC='1')  report "Falha em teste: 19" severity error;

      -- Teste: 20 - jle (com D==0)
      inInstruction <= "1110001100000110"; inZr <= '1'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='1')  report "Falha em teste: 20" severity error;

      -- Teste: 21 - jle (com D>0)
      inInstruction <= "1110001100000110"; inZr <= '0'; inNg <= '0'; 
      wait for 200 ps;
      assert(outLoadPC='0')  report "Falha em teste: 21" severity error;

      -- Teste: 22 - jle (com D<0)
      inInstruction <= "1110001100000110"; inZr <= '0'; inNg <= '1'; 
      wait for 200 ps;
      assert(outLoadPC='1')  report "Falha em teste: 22" severity error;

    test_runner_cleanup(runner); -- Simulacao acaba aqui

  end process;
end architecture;