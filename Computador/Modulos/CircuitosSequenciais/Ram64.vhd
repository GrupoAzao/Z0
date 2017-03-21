-- Elementos de Sistemas
-- by Luciano Soares
-- Ram64.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Ram64 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR( 5 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architeture Ram64_arch of Ram64 is
	type  mem is array(0 to 63) of STD_LOGIC_VECTOR(15 DOWTO 0);
	signal ram_block: mem;

begin
	process (clock)
	begin
		if (clock'event and clock = '1') then
         if (load = '1') then
            ram_block(to_integer(unsigned(address))) <= input;
         end if;
      	end if;
  	end process;
   	output <= ram_block(to_integer(unsigned(address)));
end Ram64_arch;
