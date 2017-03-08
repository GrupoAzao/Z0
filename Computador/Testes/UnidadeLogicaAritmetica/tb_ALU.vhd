library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_ALU is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_ALU is

component ALU is
	port ( 
			x,y:   in STD_LOGIC_VECTOR(15 downto 0); -- entradas de dados da ALU
			zx:    in STD_LOGIC;                     -- zera a entrada x
			nx:    in STD_LOGIC;                     -- inverte a entrada x
			zy:    in STD_LOGIC;                     -- zera a entrada y
			ny:    in STD_LOGIC;                     -- inverte a entrada y
			f:     in STD_LOGIC;                     -- se 0 calcula x & y, senão x + y
			no:    in STD_LOGIC;                     -- inverte o valor da saída
			zr:    out STD_LOGIC;                    -- setado se saída igual a zero
			ng:    out STD_LOGIC;                    -- setado se saída é negativa
			saida: out STD_LOGIC_VECTOR(15 downto 0) -- saída de dados da ALU
	); 
end component; 

   signal  inX, inY : STD_LOGIC_VECTOR(15 downto 0);
   signal  inZX, inNX, inZY, inNY, inF, inNO, outZR, outNG : STD_LOGIC;
   signal  outSaida : STD_LOGIC_VECTOR(15 downto 0);

begin

	mapping: ALU port map(inX, inY, inZX, inNX, inZY, inNY, inF, inNO, outZR, outNG, outSaida);

  main : process
  begin
    test_runner_setup(runner, runner_cfg);

      -- Teste: 1
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '0'; inZY <= '1'; inNY <= '0'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 1" severity error;

      -- Teste: 2
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '1'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001")  report "Falha em teste: 2" severity error;

      -- Teste: 3
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '1'; inNY <= '0'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 3" severity error;

      -- Teste: 4
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= '0'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 4" severity error;

      -- Teste: 5
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '0'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 5" severity error;

      -- Teste: 6
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '0'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 6" severity error;

      -- Teste: 7
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= '0'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 7" severity error;

      -- Teste: 8
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '0'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 8" severity error;

      -- Teste: 9
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 9" severity error;

      -- Teste: 10
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001")  report "Falha em teste: 10" severity error;

      -- Teste: 11
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '1'; inZY <= '1'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001")  report "Falha em teste: 11" severity error;

      -- Teste: 12
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 12" severity error;

      -- Teste: 13
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 13" severity error;

      -- Teste: 14
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111110")  report "Falha em teste: 14" severity error;

      -- Teste: 15
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 15" severity error;

      -- Teste: 16
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001")  report "Falha em teste: 16" severity error;

      -- Teste: 17
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 17" severity error;

      -- Teste: 18
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= '0'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 18" severity error;

      -- Teste: 19
      inX <= "0000000000000000"; inY <= "1111111111111111";
      inZX <= '0'; inNX <= '1'; inZY <= '0'; inNY <= '1'; inF <= '0'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 19" severity error;

      -- Teste: 20
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '1'; inNX <= '0'; inZY <= '1'; inNY <= '0'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '1' and outNG = '0' and outSaida= "0000000000000000")  report "Falha em teste: 20" severity error;

      -- Teste: 21
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '1'; inNX <= '1'; inZY <= '1'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001")  report "Falha em teste: 21" severity error;

      -- Teste: 22
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '1'; inNX <= '1'; inZY <= '1'; inNY <= '0'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111111")  report "Falha em teste: 22" severity error;

      -- Teste: 23
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= '0'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000010001")  report "Falha em teste: 23" severity error;

      -- Teste: 24
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '0'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000011")  report "Falha em teste: 24" severity error;

      -- Teste: 25
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= '0'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111101110")  report "Falha em teste: 25" severity error;

      -- Teste: 26
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '0'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111100")  report "Falha em teste: 26" severity error;

      -- Teste: 27
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111101111")  report "Falha em teste: 27" severity error;

      -- Teste: 28
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111111101")  report "Falha em teste: 28" severity error;

      -- Teste: 29
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '1'; inZY <= '1'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000010010")  report "Falha em teste: 29" severity error;

      -- Teste: 30
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000100")  report "Falha em teste: 30" severity error;

      -- Teste: 31
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '0'; inZY <= '1'; inNY <= '1'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000010000")  report "Falha em teste: 31" severity error;

      -- Teste: 32
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '1'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000010")  report "Falha em teste: 32" severity error;

      -- Teste: 33
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= '1'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000010100")  report "Falha em teste: 33" severity error;

      -- Teste: 34
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '1'; inZY <= '0'; inNY <= '0'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000001110")  report "Falha em teste: 34" severity error;

      -- Teste: 35
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '1'; inF <= '1'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '1' and outSaida= "1111111111110010")  report "Falha em teste: 35" severity error;

      -- Teste: 36
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '0'; inZY <= '0'; inNY <= '0'; inF <= '0'; inNO <= '0';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000000001")  report "Falha em teste: 36" severity error;

      -- Teste: 37
      inX <= "0000000000010001"; inY <= "0000000000000011";
      inZX <= '0'; inNX <= '1'; inZY <= '0'; inNY <= '1'; inF <= '0'; inNO <= '1';
      wait for 200 ps;
      assert(outZR = '0' and outNG = '0' and outSaida= "0000000000010011")  report "Falha em teste: 37" severity error;

    test_runner_cleanup(runner); -- Simulacao acaba aqui

  end process;
end architecture;