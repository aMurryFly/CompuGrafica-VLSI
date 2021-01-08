library ieee;
use ieee.std_logic_1164.all;

entity conta is
port(
clk		:	in		std_logic;
reset		:	in		std_logic;
count		:	out	std_logic_vector(11 downto 0)
);
end entity;

architecture arqconta of conta is
subtype state is std_logic_vector (11 downto 0);
signal present_state, next_state: state;
constant state0: state:= "000000000000";
constant state1: state:= "000000000001";
constant state2: state:= "000000000010";
constant state3: state:= "000000000011";
constant state4: state:= "000000000100";
constant state5: state:= "000000000101";
constant state6: state:= "000000000110";
constant state7: state:= "000000000111";
constant state8: state:= "000000001000";
constant state9: state:= "000000001001";
constant state10: state:="000000001010";
constant state11: state:="000000001011";
constant state12: state:="000000001100";
constant state13: state:="000000001101";
constant state14: state:="000000001110";
constant state15: state:="000000001111";


begin
process(clk)
begin  
 if rising_edge(clk) then
   if (reset='1') then
      present_state <= state0;
	else
      present_state<= next_state;
	end if;
end if;
end process;

process(present_state)  
begin
case present_state is
when state0=>	next_state<= state1;  
when state1=>	next_state<= state2;
when state2=>	next_state<= state3;
when state3=>	next_state<= state4;
when state4=>	next_state<= state5; 
when state5=>	next_state<= state6;
when state6=>	next_state<= state7;
when state7=>	next_state<= state8;
when state8=>	next_state<= state9; 
when state9=>	next_state<= state10;
when state10=>	next_state<= state11;
when state11=>	next_state<= state12;
when state12=>	next_state<= state13;  
when state13=>	next_state<= state14;
when state14=>	next_state<= state15;
when state15=>	next_state<= state0;
when others=>	next_state<= state0;
end case;

count <= present_state;
end process;


end arqconta;

	