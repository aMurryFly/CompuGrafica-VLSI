library ieee;
use ieee.std_logic_1164.all;

entity display is port(
	UA, UL: in std_logic_vector(2 downto 0);
	sel: in std_logic_vector (2 downto 0);
	cout: in std_logic;
	disp0, disp1, disp2: out std_logic_vector(6 downto 0);
	salfinal: out std_logic_vector(3 downto 0)
);
end entity;
architecture arq_disp of display is 
signal uaparcial, uaparcial2,ulparcial: std_logic_vector( 3 downto 0);

begin

	process(sel,cout,UA,UL)
	begin
		--UA
		if(sel(2)='0') then
			--resta
			if (sel(1 downto 0) ="01" OR sel(1 downto 0) ="11") then
				--uaparcial <=cout&UA;
					uaparcial <= '0'&UA;
				case uaparcial is 
					when "0000" => disp0 <="1000000";--0
					when "0001" => disp0 <="1111001";--1
					when "0010" => disp0 <="0100100";--2
					when "0011" => disp0 <="0110000";--3
					when "0100" => disp0 <="0011001";--4
					when "0101" => disp0 <="0010010";--5
					when "0110" => disp0 <="0000010";--6
					when "0111" => disp0 <="1111000";--7
					when "1000" => disp0 <="1000000";--0
					when "1001" => disp0 <="1111001";--1
					when "1010" => disp0 <="0100100";--2
					when "1011" => disp0 <="0110000";--3
					when "1100" => disp0 <="0011001";--4
					when "1101" => disp0 <="0010010";--5
					when "1110" => disp0 <="0000010";--6
					when "1111" => disp0 <="1111000";--7
					when others => disp0 <="1000000";
				end case;
				
				disp1 <= "1000000";
				disp2 <= "1111111";
				salfinal <= uaparcial;
			--suma y casos extra
			else
				uaparcial2 <= '0'&UA;
				
				case uaparcial2 is 
					when "0000" => disp0 <="1000000";--0
					when "0001" => disp0 <="1111001";--1
					when "0010" => disp0 <="0100100";--2
					when "0011" => disp0 <="0110000";--3
					when "0100" => disp0 <="0011001";--4
					when "0101" => disp0 <="0010010";--5
					when "0110" => disp0 <="0000010";--6
					when "0111" => disp0 <="1111000";--7
					when "1000" => disp0 <="0000000";--8
					when "1001" => disp0 <="0011000";--9
					when "1010" => disp0 <="1000000";--10
					when "1011" => disp0 <="1111001";--11
					when "1100" => disp0 <="0100100";--12
					when "1101" => disp0 <="0110000";--13
					when "1110" => disp0 <="0011001";--14
					when "1111" => disp0 <="0010010";--15
					when others => disp0 <="1000000";
				end case;
				
				case uaparcial2 is 
					when "0000" => disp1 <="1000000";--0
					when "0001" => disp1 <="1000000";--1
					when "0010" => disp1 <="1000000";--2
					when "0011" => disp1 <="1000000";--3
					when "0100" => disp1 <="1000000";--4
					when "0101" => disp1 <="1000000";--5
					when "0110" => disp1 <="1000000";--6
					when "0111" => disp1 <="1000000";--7
					when "1000" => disp1 <="1000000";--8
					when "1001" => disp1 <="1000000";--9
					when "1010" => disp1 <="1111001";--10
					when "1011" => disp1 <="1111001";--11
					when "1100" => disp1 <="1111001";--12
					when "1101" => disp1 <="1111001";--13
					when "1110" => disp1 <="1111001";--14
					when "1111" => disp1 <="1111001";--15
					when others => disp1 <="1000000";
				end case;
				
				disp2 <= "1111111";
				
				salfinal <= uaparcial2;
			
			end if;
		--UL	
		else
			ulparcial <= '0'&UL;
			case ulparcial (0) is
				when '1' => disp0 <= "1111001";
				when '0' => disp0 <= "1000000";
				when others =>disp0<="1111111";
			end Case;
			case ulparcial (1) is
				when '1' => disp1 <= "1111001";
				when '0' => disp1 <= "1000000";
				when others =>disp1<="1111111";
			end Case;
			case ulparcial (2) is
				when '1' => disp2 <= "1111001";
				when '0' => disp2 <= "1000000";
				when others =>disp2<="1111111";
			end Case;
			
			salfinal <='0'&UL;
			
		end if;
	end process;
end architecture arq_disp;