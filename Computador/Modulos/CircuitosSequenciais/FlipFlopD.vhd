-- Elementos de Sistemas
-- by Luciano Soares
-- FlipFlopD.vhd

library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopD is
	port(
		clock:  in std_logic;
		d:      in std_logic;
		clear:  in std_logic;
		preset: in std_logic;
		q:     out std_logic
	);
end entity;

architecture arch of FlipFlopD is
begin
	process(clock, clear, preset) begin
		if (clear = '0') then
			q <='0';
		elsif (preset = '0') then
			q <='1';
		elsif (rising_edge(CLOCK)) then
			q<=D;
		end if;
	end process;
end architecture;