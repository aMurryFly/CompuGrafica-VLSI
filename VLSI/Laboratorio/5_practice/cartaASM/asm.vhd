library ieee;
use ieee.std_logic_1164.all;

entity asm is
port (
clk, reset: in std_logic;
x,y : in std_logic;
var1,var2,var3,var4: out std_logic;
SalMoore: inout std_logic_vector(3 downto 0)
);
end entity;

architecture arqasm of asm is
subtype state is std_logic_vector(3 downto 0);
signal present_State, next_state:state;
constant state0: state := "0000";
constant state1: state := "0001";
constant state2: state := "0010";
constant state3: state := "0011";
constant state4: state := "0100";
constant state5: state := "0101";
constant state6: state := "0110";
constant state7: state := "0111";
constant state8: state := "1000";
begin


process(clk)
begin
if rising_edge(clk) then
	if (reset='0') then
	present_state<=state0;
	else
	present_state<=next_state;
	end if;
end if;
end process;

process (present_state)
begin
case present_state is
when state0 =>
			if(x = '0') then
				next_state <= state1;
				var1<='1';
				var2<='0';
				var3<='0';
				var4<='0';
				else
				next_state <= state2;
				var1<='1';
				var2<='1';
				var3<='0';
				var4<='0';
			end if;
	
when state1 =>
			if(y='0') then
				next_state <= state3;
				var1<='0';
				var2<='0';
				var3<='1';
				var4<='0';
				else
				next_state <= state8;
				var1<='0';
				var2<='0';
				var3<='1';
				var4<='1';
			end if;
				
when state2 =>
			if(y='0') then
				next_state <= state5;
				var1<='0';
				var2<='0';
				var3<='1';
				var4<='1';
			else
				next_state <= state7;
				var1<='1';
				var2<='0';
				var3<='0';
				var4<='0';
			end if;
				
when state3 =>  next_state <= state4;
				var1<='0';
				var2<='0';
				var3<='1';
				var4<='1';

				
when state4 =>  next_state <= state8;
				var1<='0';
				var2<='0';
				var3<='1';
				var4<='1';

when state5 =>  next_state <= state6;
				var1<='0';
				var2<='0';
				var3<='1';
				var4<='0';			

when state6 =>  next_state <= state7;
				var1<='1';
				var2<='0';
				var3<='0';
				var4<='0';			
			
when state7 =>  next_state <= state0;
				var1<='0';
				var2<='0';
				var3<='0';
				var4<='0';
				
when state8 =>  next_state <= state0;
				var1<='0';
				var2<='0';
				var3<='0';
				var4<='0';

				
when others=> next_state<=state0;
				var1<='0';
				var2<='0';
				var3<='0';
				var4<='0';

end case;
salMoore<=present_state;
end process;
end arqasm;
		
		