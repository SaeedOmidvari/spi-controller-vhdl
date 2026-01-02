library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SPI_Controller_tb is
end SPI_Controller_tb;

architecture Behavioral of SPI_Controller_tb is

	signal  aclk        		:   std_logic                       :=  '0';
	signal  Force_CS        	:   std_logic                       :=  '0';
	signal  MISO        		:   std_logic                       :=  '0';
	signal  Send        		:   std_logic                       :=  '0';
	signal  Busy        		:   std_logic                       :=  '0';
	signal  CS        			:   std_logic                       :=  '0';
	signal  Data_Out_Valid     	:   std_logic                       :=  '0';
	signal  MOSI        		:   std_logic                       :=  '0';
	signal  SCK        		    :   std_logic                       :=  '0';
	signal  Command_Type     	:   unsigned	(1 downto 0)        :=  (others=>'0');
	signal  Data_In        		:   unsigned	(31 downto 0)       :=  (others=>'0');
	signal  Data_Out        	:   unsigned	(7 downto 0)        :=  (others=>'0');
	
	constant CLOCK_PERIOD 		: time := 10 ns;
	constant T_HOLD       		: time := 10 ns;


begin

SPI_Controller_inst: entity work.SPI_Controller
   port map (
      -- Input Ports - Single Bit
      Clock                    => aclk,                  
      Force_CS                 => Force_CS,               
      MISO                     => MOSI,                   
      Send                     => Send,                   
      -- Input Ports - Busses
      Command_Type			   => Command_Type,
      Data_In				   => Data_In,   
      -- Output Ports - Single Bit
      Busy                     => Busy,                   
      CS                       => CS,                     
      Data_Out_Valid           => Data_Out_Valid,         
      MOSI                     => MOSI,                   
      SCK                      => SCK,                    
      -- Output Ports - Busses
      Data_Out				   => Data_Out   
   );



  clock_gen : process
  begin
    aclk <= '0';

      wait for CLOCK_PERIOD;
      loop
        aclk <= '0';
        wait for CLOCK_PERIOD/2;
        aclk <= '1';
        wait for CLOCK_PERIOD/2;
      end loop;
  end process clock_gen;

  stimuli : process
  begin

    -- Drive inputs T_HOLD time after rising edge of clock
    wait until rising_edge(aclk);
    wait for T_HOLD;

    -- Run for long enough to produce 5 periods of outputs
    wait for CLOCK_PERIOD * 50;


	
	 Force_CS		    <=	'1';               
	 Send				<=	'0';                   
	
	 Command_Type	    <=	to_unsigned(2,2);
	 Data_In			<=	x"00FF55AA";   

    wait for CLOCK_PERIOD * 1000;

	 Send				<=	'1';                   
    wait for CLOCK_PERIOD * 1;
	 Send				<=	'0';                   

    wait for CLOCK_PERIOD * 1000;
	 Send				<=	'1';                   

	
    wait;

  end process stimuli;


end Behavioral;
