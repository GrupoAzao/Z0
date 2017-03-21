-- Elementos de Sistemas
-- by Luciano Soares
-- Ram8.vhd

Library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity Ram8 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR( 2 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

ARCHITECTURE rtl OF Ram8 IS
   TYPE mem IS ARRAY(0 TO 7) OF std_logic_vector(15 DOWNTO 0);
   SIGNAL ram_block : mem;
BEGIN
   PROCESS (clock)
   BEGIN
      IF (clock'event AND clock = '1') THEN
         IF (load = '1') THEN
            ram_block(to_integer(unsigned(address))) <= input;
         END IF;
      END IF;
      output <= ram_block(to_integer(unsigned(address)));
   END PROCESS;
END rtl;
