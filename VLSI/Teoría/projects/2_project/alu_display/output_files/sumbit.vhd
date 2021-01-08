library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_ARITH.all;
use ieee.std_logic_UNSIGNED.all;

Entity sumbit2 is 
port (
a,b2: in std_logic_vector (1 downto 0);
cin: in std_logic;
sal: out std_logic_vector(1 downto 0);
cout: out std_logic_vector(1 downto 0)
);
end entity sumbit2;

architecture arqsb2 of sumbit2 is
signal mid: std_logic_vector(2 downto 0);
begin 

sal<= a xor b2 xor ('0' & cin);
cout<= (a and b2) or (('0' & cin) and (a or b2));

end architecture arqsb2;