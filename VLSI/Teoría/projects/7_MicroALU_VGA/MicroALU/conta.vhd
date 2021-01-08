library ieee;
use ieee.std_logic_1164.all;

entity conta is 
port(
		clk, reset,pausa: in std_logic;
		count: out std_logic_vector(3 downto 0)
		);
end conta;

architecture arqconta of conta is
subtype state is std_logic_vector(3 downto 0);
signal present_state, next_state: state;

constant state0: state:= "0000";
constant state1: state:= "0001";
constant state2: state:= "0010";
constant state3: state:= "0011";
constant state4: state:= "0100";
constant state5: state:= "0101";
constant state6: state:= "0110";
constant state7: state:= "0111";
constant state8: state:= "1000";
constant state9: state:= "1001";
constant state10: state:= "1010";
constant state11: state:= "1011";
constant state12: state:= "1100";
constant state13: state:= "1101";
constant state14: state:= "1110";
constant state15: state:= "1111";


begin
	process(clk)
	begin
		if rising_edge(clk) then 
			if (reset='0') then
				present_state <= state0;
			elsif(pausa ='1') then
				present_state <= present_state;
			else
				present_state <= next_state;
			end if;
		end if;
	end process;
	process (present_state)
begin
	case present_state is
		when state0=> next_state <= state1;
		when state1=> next_state <= state2;
		when state2=> next_state <= state3;
		when state3=> next_state <= state4;
		when state4=> next_state <= state5;
		when state5=> next_state <= state6;
		when state6=> next_state <= state7;
		when state7=> next_state <= state8;
		when state8=> next_state <= state9;
		when state9=> next_state <= state10;
		when state10=> next_state <= state11;
		when state11=> next_state <= state12;
		when state12=> next_state <= state13;
		when state13=> next_state <= state14;
		when state14=> next_state <= state15;
		when state15=> next_state <= state0;
		when others =>
		next_state<= state0;
	end case;
	count <= present_state;
	end process;
end arqconta;