library ieee;
use ieee.std_logic_1164.all;
entity eje69 is port
(
	clk, boton, reset: in std_logic;
	lampara: out std_logic;
	estado: out std_logic_vector(1 downto 0)
);
end entity;
architecture arqeje69 of eje69 is
subtype state is std_logic_vector(1 downto 0);
signal present_state, next_state: state;
constant e0: state:="00";
constant e1: state:="01";
constant e2: state:="10";
constant e3: state:="11";
begin 
	process(clk)
	begin
		if rising_edge (clk) then
			if(reset='1') then
				present_state<=e0;
			else
				present_state<=next_state;
			end if;
		end if;
	end process;
	process(present_state, boton)
	begin
		case present_state is
			when e0 => lampara <='0';
				if boton='0' then next_state<= e0; end if;
				if boton='1' then next_state<= e1; end if;
			when e1 => lampara <='1';
				if boton='0' then next_state<= e2; end if;
				if boton='1' then next_state<= e1; end if;
			when e2 => lampara <='1';
				if boton='0' then next_state<= e2; end if;
				if boton='1' then next_state<= e3; end if;
			when others=> lampara<='0';
				if boton='0' then next_state<= e0; end if;
				if boton='1' then next_state<= e3; end if;
		end case;
	estado<=present_state;
	end process;
	end architecture;