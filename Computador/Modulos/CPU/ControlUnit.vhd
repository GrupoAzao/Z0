
-- Unidade que controla os componentes da CPU

library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
    port(
		instruction                 : in STD_LOGIC_VECTOR(15 downto 0);  -- instrução para executar
		zr,ng                       : in STD_LOGIC;                      -- valores zr(se zero) e ng(se negativo) da ALU
		muxALUI_A                   : out STD_LOGIC;                     -- mux que seleciona entre instrução e ALU para reg. A
		muxAM_ALU                   : out STD_LOGIC;                     -- mux que seleciona entre reg. A e Mem. RAM para ALU
		zx, nx, zy, ny, f, no       : out STD_LOGIC;                     -- sinais de controle da ALU
		loadA, loadD, loadM, loadPC : out STD_LOGIC                      -- sinais de load do reg. A, reg. D, Mem. RAM e Program Counter
		
		
    );
end entity;

architecture CU of ControlUnit is

begin	

muxALUI_A <= !instruction(0);
loadA <= !instruction(0);
muxAM_ALU <= instruction(3) and instruction(0);

zx <= instruction(4) and instruction(0);
nx <= instruction(5) and instruction(0);
zy <= instruction(6) and instruction(0);
ny <= instruction(7) and instruction(0);
f <= instruction(8) and instruction(0);
no <= instruction(9) and instruction(0);

loadA <= instruction(10) or !instruction(0);
loadD <= instruction(11) and instruction(0);
loadM <= instruction(12) and instruction(0);

loadPC <= (instruction(15) and !ng and !zr) or (instruction(14) and zr) or (instruction(13) and ng and !zr);
	
end architecture;
	