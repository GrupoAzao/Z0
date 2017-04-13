
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
		loadA, loadD, loadM, loadPC : out STD_LOGIC                     -- sinais de load do reg. A, reg. D, Mem. RAM e Program Counter
		
		
    );
end entity;

architecture CU of ControlUnit is

begin	

muxALUI_A <= not instruction(15);
loadA <= not instruction(15) or instruction(5);
muxAM_ALU <= instruction(12) and instruction(15);

zx <= instruction(11) and instruction(15);
nx <= instruction(10) and instruction(15);
zy <= instruction(9) and instruction(15);
ny <= instruction(8) and instruction(15);
f <= instruction(7) and instruction(15);
no <= instruction(6) and instruction(15);

loadD <= instruction(4) and instruction(15);
loadM <= instruction(3) and instruction(15);

loadPC <= ((instruction(0) and not ng and not zr) or (instruction(1) and zr) or (instruction(2) and ng and not zr)) and instruction(15);
	
end architecture;