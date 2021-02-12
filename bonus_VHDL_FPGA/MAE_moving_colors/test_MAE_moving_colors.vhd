library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity test_MAE_moving_colors is 
end  test_MAE_moving_colors ;

architecture archi of test_MAE_moving_colors  is 
signal clk100: std_logic :='0';
signal reset: std_logic  :='0';
signal GREEN_out,BLUE_out, RED_out :std_logic_vector(3 downto 0);
signal  inc_r , dec_r ,inc_g,dec_g ,inc_b , dec_b : std_logic;

begin 
instance : entity work.MAE_moving_colors
           port map(clk100,reset,
                   RED_out,
                   GREEN_out ,
                   BLUE_out ,
                   inc_r , dec_r ,
                   inc_g , dec_g ,
                   inc_b , dec_b);
RED_out<="1111", "1110" after 100 ns, "1101" after 200 ns , "0000" after 500 ns, "1111" after 1000 ns;
GREEN_out<="0000","1111" after 100 ns, "1110" after 200 ns , "1111" after 500 ns , "0000" after 600 ns;
BLUE_out<= "1111","1110" after 100 ns, "1101" after 200 ns , "1111" after 600 ns , "0000" after 1000 ns;
clk100<= not clk100 after 5 ns;
reset <= '1' after 3 ns; 
end archi;