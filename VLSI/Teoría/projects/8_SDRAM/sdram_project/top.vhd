library ieee;
use ieee.std_logic_1164.all;


entity top is port(
    ADC_CLK_10: in std_logic;
    MAX10_CLK1_50: in std_logic;
    MAX10_CLK2_50: in std_logic;
    --SDRAM
    DRAM_ADDR: out std_logic_vector(12 downto 0);
    DRAM_BA:     out std_logic_vector(1 downto 0);
    DRAM_CAS_N: out std_logic;
    DRAM_CKE:    out std_logic;
    DRAM_CLK:    out std_logic;
    DRAM_CS_N:     out std_logic;
    DRAM_DQ: inout std_logic_vector(15 downto 0);
    DRAM_LDQM:    out std_logic;
    DRAM_RAS_N: out std_logic;
    DRAM_UDQM:     out std_logic;
    DRAM_WE_N:    out std_logic;

    --ENTRADAS
    key:        in std_logic_vector(1 downto 0);
    ledr:        out    std_logic_vector(9 downto 0);
    sw:        in std_logic_vector(9 downto 0)

);
end entity;


architecture arqtop of top is

variable data: std_logic_vector(127 downto 0);
variable state: std_logic_vector(4 downto 0):= "00001";
variable next_state: std_logic_vector(4 downto 0):="00010";
signal address: std_logic_vector(21 downto 0);
signal reset:    std_logic;
signal write_command: std_logic;
signal read_command:std_logic;
signal write_finished:std_logic;
signal read_finished:std_logic;
signal write_data:std_logic_vector(127 downto 0);
signal read_data:std_logic_vector(127 downto 0);

variable write_request:std_logic;
variable read_request:std_logic;



	component sdram_controller is port(
	
		 MAX10_CLK1_50: in std_logic;
		 reset: in std_logic;
		 write_request: in std_logic;
		 write_address: in std_logic_vector(21 downto 0); 
		 write_data: in std_logic_vector(127 downto 0);
		 write_finished: out std_logic;
		 
		 read_request: in std_logic;
		 read_address: in std_logic_vector(21 downto 0);
		 read_data: out std_logic_vector(127 downto 0);
		 read_finished: out std_logic;
		 
		 --SDRAM
		 DRAM_ADDR: out std_logic_vector(12 downto 0);
		 DRAM_BA:     out std_logic_vector(1 downto 0);
		 DRAM_CAS_N: out std_logic;
		 DRAM_CKE:    out std_logic;
		 DRAM_CLK:    out std_logic;
		 DRAM_CS_N:     out std_logic;
		 DRAM_DQ: inout std_logic_vector(15 downto 0);
		 DRAM_LDQM:    out std_logic;
		 DRAM_RAS_N: out std_logic;
		 DRAM_UDQM:     out std_logic;
		 DRAM_WE_N:    out std_logic

	);
	end component;




begin

write_data<=SW;
LEDR<=data(9 downto 0);
write_command<= not key(0);
read_command<=not key(1);


process(MAX10_CLK1_50)
begin
		if(rising_edge(MAX10_CLK1_50)) then
			state := next_state;
		end if;
end process;


process(state, write_command, read_command,write_finished,read_finished)
begin
    case state is
        when "00001"=>
            if(write_command ='1') then
                next_state  := "00010";
            elsif(read_command='1') then
                next_state  := "01000";
            else
                next_state  := "00001";
				end if;
        when "00010"=>
            if(write_finished='1') then
                next_state  := "00100";
            else
                next_state  := "00010";
				end if;	 
        when "00100"=>
            next_state      := "00001";

        when "01000"=>
            if(read_finished ='1') then
                next_state  := "10000";
            else
                next_state  := "01000";
				end if;	 
        when "10000"=>
            next_state      := "00001";
    end case;
end process;


process(state)
begin
    case state is
        when "00001"=>
        
            write_request   := '0';
            read_request    := '0';
        

        when "00010"=>
        
            write_request   := '1';
            read_request    := '0';
        
        when "00100" =>
        
            write_request   := '0';
            read_request    := '0';
        

        when "01000" =>
        
            write_request   := '0';
            read_request    := '1';
        
        when "10000" =>
        
            write_request   := '0';
            read_request    := '0';
            data            := read_data;
        
   end case;	 
	 
end process;

--u1: entity work.sdram_controller (sdram_controller) port map(
   
u1: sdram_controller port map(
  
	 MAX10_CLK1_50 => MAX10_CLK1_50,
    reset => reset,
    write_request=> write_request,
    write_address => address, 
    write_data => address,
    write_finished => write_finished, 
	 
	 read_request => read_request,
    read_address => address,
    read_data => read_data,
    read_finished => read_finished,
	 
	 DRAM_ADDR => DRAM_ADDR,
    DRAM_BA => DRAM_BA,
    DRAM_CAS_N => DRAM_CAS_N,
    DRAM_CKE => DRAM_CKE,
    DRAM_CLK => DRAM_CLK,
    DRAM_CS_N => DRAM_CS_N,
    DRAM_DQ => DRAM_DQ,
    DRAM_LDQM => DRAM_LDQM,
    DRAM_RAS_N => DRAM_RAS_N,
    DRAM_UDQM => DRAM_UDQM,
    DRAM_WE_N => DRAM_WE_N
	
);


end architecture;