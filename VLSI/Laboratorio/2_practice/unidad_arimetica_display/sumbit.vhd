library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_ARITH.all;
use ieee.std_logic_UNSIGNED.all;

Entity sumbit is 
port (
a,b2: in std_logic_vector (2 downto 0);
cin: in std_logic;
sal: out std_logic_vector(2 downto 0);
cout: out std_logic
);
end entity sumbit;

architecture arqsb of sumbit is
signal mid: std_logic_vector(3 downto 0);
begin 

mid<= ('0' & a)+('0' & b2)+ cin;
cout<= mid(3);
sal<= mid(2 downto 0);


end architecture arqsb;