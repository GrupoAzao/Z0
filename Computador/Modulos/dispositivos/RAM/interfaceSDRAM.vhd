library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use work.all;

entity interfaceSDRAM is

    PORT(
        -- Sistema
        CLK_50  : IN  STD_LOGIC; -- 50 Mhz
		  rst			: in std_logic;
  
        -- I/Os digital
		  --KEY : in  std_logic_vector(1 downto 0);
		  CPU_INPUT : in std_logic_vector(15 downto 0) := (others => '0');
        CPU_OUTPUT : out std_logic_vector(15 downto 0) := (others => '0');
        CPU_ADDRESS : in std_logic_vector(13 downto 0) := (others => '0');
		  CPU_LOAD  : IN  STD_LOGIC;
		  
        -- SDRAM
        DRAM_ADDR   : out   std_logic_vector(12 downto 0);
        DRAM_BA     : out   std_logic_vector(1  downto 0);
        DRAM_CAS_N  : out   std_logic;  
        DRAM_CKE    : out   std_logic;
        DRAM_CLK    : out   std_logic;
        DRAM_CS_N   : out   std_logic;
        DRAM_DQ     : inout std_logic_vector(15 downto 0);
        DRAM_DQM    : out   std_logic_vector(01 downto 0);
        DRAM_RAS_N  : out   std_logic;
        DRAM_WE_N   : out   std_logic
    );
end entity;

ARCHITECTURE logic OF interfaceSDRAM IS

    component sdram is
        port (
            sdram_wire_addr                 : out   std_logic_vector(12 downto 0);                    
            sdram_wire_ba                   : out   std_logic_vector(1 downto 0);                     
            sdram_wire_cas_n                : out   std_logic;                                        
            sdram_wire_cke                  : out   std_logic;                                        
            sdram_wire_cs_n                 : out   std_logic;                                        
            sdram_wire_dq                   : inout std_logic_vector(15 downto 0); 
            sdram_wire_dqm                  : out   std_logic_vector(1 downto 0); 
            sdram_wire_ras_n                : out   std_logic;                    
            sdram_wire_we_n                 : out   std_logic;                    
            sdram_s1_address                : in    std_logic_vector(23 downto 0); 
            sdram_s1_byteenable_n           : in    std_logic_vector(1 downto 0);  
            sdram_s1_chipselect             : in    std_logic;                     
            sdram_s1_writedata              : in    std_logic_vector(15 downto 0); 
            sdram_s1_read_n                 : in    std_logic;                     
            sdram_s1_write_n                : in    std_logic;                     
            sdram_s1_readdata               : out   std_logic_vector(15 downto 0);
            sdram_s1_readdatavalid          : out   std_logic;                    
            sdram_s1_waitrequest            : out   std_logic;                    
			altpll_areset_conduit_export    : in    std_logic;                     
            altpll_locked_conduit_export    : out   std_logic;         
            altpll_sdram_clk                : out   std_logic;                    
            clk_clk                         : in    std_logic;                     
            clk100_clk                      : out   std_logic;                    
            reset_reset_n                   : in    std_logic                     
        );
    end component sdram;


    signal altpll_locked            : std_logic;
	signal clk100 				    : std_logic;
	 
    signal sdram_s1_address         :  std_logic_vector(23 downto 0); 
    signal sdram_s1_byteenable_n    :  std_logic_vector(1  downto 0); 
    signal sdram_s1_chipselect      :  std_logic                    ; 
    signal sdram_s1_writedata       :  std_logic_vector(15 downto 0); 
    signal sdram_s1_read_n          :  std_logic                    ; 
    signal sdram_s1_write_n         :  std_logic                    ; 
    signal sdram_s1_readdata        :  std_logic_vector(15 downto 0);
    signal sdram_s1_readdatavalid   :  std_logic                    ; 
    signal sdram_s1_waitrequest     :  std_logic                    ; 

	constant addressOffset		    : integer := 0;
	constant addressTestSize        : integer := 255;
    signal   address                : std_logic_vector(13 downto 0);

    signal  dataWrite               : unsigned(7 downto 0) := (others => '0');
	 
    signal delayCounter             : integer range 0 to 100000000 := 0;

    type   STATE_TYPE IS (s0, sW1, sW2, sR0, sR1, sR2, sR3, sDelay);
    signal state   : STATE_TYPE := s0;

    
begin

    u0 : component sdram
        port map (
            sdram_wire_addr                 => DRAM_ADDR,
            sdram_wire_ba                   => DRAM_BA,
            sdram_wire_cas_n                => DRAM_CAS_N,
            sdram_wire_cke                  => DRAM_CKE,
            sdram_wire_cs_n                 => DRAM_CS_N,
            sdram_wire_dq                   => DRAM_DQ,
            sdram_wire_dqm                  => DRAM_DQM,
            sdram_wire_ras_n                => DRAM_RAS_N,
            sdram_wire_we_n                 => DRAM_WE_N,
            sdram_s1_address                => sdram_s1_address     , 
            sdram_s1_byteenable_n           => sdram_s1_byteenable_n, 
            sdram_s1_chipselect             => sdram_s1_chipselect  , 
            sdram_s1_writedata              => sdram_s1_writedata   , 
            sdram_s1_read_n                 => sdram_s1_read_n      , 
            sdram_s1_write_n                => sdram_s1_write_n     , 
            sdram_s1_readdata               => sdram_s1_readdata    , 
            sdram_s1_readdatavalid          => sdram_s1_readdatavalid,
            sdram_s1_waitrequest            => sdram_s1_waitrequest , 
			altpll_areset_conduit_export    => '0',
			altpll_locked_conduit_export    => altpll_locked,
            clk_clk                         => CLK_50,
			altpll_sdram_clk		        => DRAM_CLK,
			clk100_clk				        => clk100,
            reset_reset_n                   => rst
        );


		  
    -- Fluxo :
	 -- 	1. Grava valor na SDRAM 
	 -- 	2. Le da SRDAM e mostra nos LEDs
	 -- 	3. Incrementa endereco SDRAM + modifica valor salvo
	 -- 

	 
	 -- !!!!! FUNCIONA DIREITO SÓ DEPOIS DO BOTAO DE RESET  !!!!!!!!!
	 
	 
    process(clk100)
    begin
    	if((rst = '0') OR (altpll_locked ='0') ) then 
			--CPU_OUTPUT 				<= X"0000";
			delayCounter			<= 0 ;
			state 	 				<= sR1;
			address 	 				<= (others => '0');
			dataWrite 				<= (others => '0');
         sdram_s1_write_n     <= '1';
         sdram_s1_read_n      <= '1';
			sdram_s1_chipselect 	<= '1';
		else  
			if(rising_edge(clk100)) then
				case state is
				
					when sW1 =>
							-- CPU_OUTPUT(7 DOWNTO 4) 				<= "0001";
                    	sdram_s1_chipselect 	<= '1';
                        if(delayCounter < 50000000) then
                            delayCounter     <= delayCounter + 1;
                            sdram_s1_write_n <= '1';
                            state            <= sW1;
                        else
                            delayCounter     <= 0;
                            sdram_s1_write_n <= '0';                                             
                            state            <= sW2;
                        end if;

                    when sW2 =>
						  	   -- CPU_OUTPUT(7 DOWNTO 4) 				<= "0010";
                        sdram_s1_write_n <= '1';
								if(CPU_LOAD = '1') then
									state            <= sW1;
								else
									state 			  <= sR1;
								end if;
								
                    when sR1 =>
						  		-- CPU_OUTPUT(7 DOWNTO 4) 				<= "0100";
                        if(delayCounter < 50000000) then
                            delayCounter    <= delayCounter + 1;
                            sdram_s1_read_n <= '1';
                            state           <= sR1;
                        else
                            delayCounter    <= 0;
                            sdram_s1_read_n <= '0';                                             
                            state           <= sR2;
                        end if;
								
                    when sR2 =>
						  		--CPU_OUTPUT(7 DOWNTO 4) 				<= "1000";
                        sdram_s1_read_n <= '1';
								address 			 <= CPU_ADDRESS;
                        if(sdram_s1_readdatavalid = '1') then
                            CPU_OUTPUT 	<= sdram_s1_readdata;
									 --CPU_OUTPUT(15 downto 1) 	<= sdram_s1_readdata(15 downto 1);
									 --CPU_OUTPUT(0) 				<= '0';

									 if(CPU_LOAD = '1') then
									 	--CPU_OUTPUT(0) 			<= '0';
										state   				 	<= sW1;
										--sdram_s1_writedata 	<= CPU_INPUT;
									 else
										state   					<= sR1;
									 end if;
									 
                        else
                            state <= sR2;
                        end if;
                        
					when others =>
						state <= sW1;
							
				end case;
			end if;
       end if; 
    end process;

    sdram_s1_address    			<= "0000000000" & address; 
    sdram_s1_byteenable_n 		   <= (others => '0');
    sdram_s1_waitrequest  			<= '0'; 
	 sdram_s1_writedata 	<= CPU_INPUT;

end;




