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

architecture Add16_arch of Add16 is
begin

    HalfAdder(a=a[0], b=b[0], sum=q[0], carry=carry1);
    FullAdder(a=a[1], b=b[1], c=carry1, sum=q[1], carry=carry2);
    FullAdder(a=a[2], b=b[2], c=carry2, sum=q[2], carry=carry3);
    FullAdder(a=a[3], b=b[3], c=carry3, sum=q[3], carry=carry4);
    FullAdder(a=a[4], b=b[4], c=carry4, sum=q[4], carry=carry5);
    FullAdder(a=a[5], b=b[5], c=carry5, sum=q[5], carry=carry6);
    FullAdder(a=a[6], b=b[6], c=carry6, sum=q[6], carry=carry7);
    FullAdder(a=a[7], b=b[7], c=carry7, sum=q[7], carry=carry8);
    FullAdder(a=a[8], b=b[8], c=carry8, sum=q[8], carry=carry9);
    FullAdder(a=a[9], b=b[9], c=carry9, sum=q[9], carry=carry10);
    FullAdder(a=a[10], b=b[10], c=carry10, sum=q[10], carry=carry11);
    FullAdder(a=a[11], b=b[11], c=carry11, sum=q[11], carry=carry12);
    FullAdder(a=a[12], b=b[12], c=carry12, sum=q[12], carry=carry13);
    FullAdder(a=a[13], b=b[13], c=carry13, sum=q[13], carry=carry14);
    FullAdder(a=a[14], b=b[14], c=carry14, sum=q[14], carry=carry15);
    FullAdder(a=a[15], b=b[15], c=carry15, sum=q[15], carry=carry16);

end architecture;
