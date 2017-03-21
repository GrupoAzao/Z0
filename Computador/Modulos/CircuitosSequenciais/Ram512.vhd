-- Elementos de Sistemas
-- by Luciano Soares
-- Ram512.vhd

Library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity Ram512 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR(8 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

ARCHITECTURE arch_ram512 OF Ram512 IS
   TYPE mem IS ARRAY(0 TO 511) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL ram_block : mem;
BEGIN
   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
         IF (load = '1') THEN
            ram_block(to_integer(unsigned(address))) <= input;
         END IF;
      END IF;
   END PROCESS;
   output <= ram_block(to_integer(unsigned(address)));
END arch_ram512;
