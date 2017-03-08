-- Soma dois valores de 16 bits
-- ignorando o carry mais significativo

library IEEE; 
use IEEE.STD_LOGIC_1164.all;
  
entity Add16 is
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		b   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0) 
	); 
end entity; 
