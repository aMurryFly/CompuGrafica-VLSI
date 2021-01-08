library ieee;
use ieee.std_logic_1164.all;
entity par is port(
	clk,E,reset: in std_logic;
	s: out std_logic
);
end entity;
architecture arqpar of par is
subtype state is std_logic_vector(1 downto 0);
signal present_state, next_state:state;
constant e0: state:="00";
constant non: state:="01";
constant par: state:="10";

begin
	process(clk)
	begin
	if rising_edge(clk) then
		if(reset='1') then
			present_state<=e0;
		else
			present_state<=next_state;
		end if;
	end if;
	end process;
	
	process(present_state)
	begin
		case present_state is 
		when e0=>
			if(E='0') then next_state <=e0; end if;
			if(E='1') then next_state <=non; end if;
			S<='0';
		when non=>
			if(E='0') then next_state <=non; end if;
			if(E='1') then next_state <=par; end if;
			S<='0';
		when par=>
			if(E='0') then next_state <=par; end if;
			if(E='1') then next_state <=non; end if;
			S<='1';
		when others => next_state<=e0;
		end case;
	end process;
end architecture;
