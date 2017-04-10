
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CPU is
    port(
        clock:	     in  STD_LOGIC;                        -- sinal de clock para CPU
        inM:         in  STD_LOGIC_VECTOR(15 downto 0);    -- dados lidos da memória RAM
        instruction: in  STD_LOGIC_VECTOR(15 downto 0);    -- instrução (dados) vindos da memória ROM
        reset:       in  STD_LOGIC;                        -- reinicia toda a CPU (inclusive o Program Counter)
        outM:        out STD_LOGIC_VECTOR(15 downto 0);    -- dados para gravar na memória RAM
        writeM:      out STD_LOGIC;                        -- faz a memória RAM gravar dados da entrada
        addressM:    out STD_LOGIC_VECTOR(14 downto 0);    -- envia endereço para a memória RAM
        pcout:       out STD_LOGIC_VECTOR(14 downto 0)     -- endereço para ser enviado a memória ROM
  );
end entity;

