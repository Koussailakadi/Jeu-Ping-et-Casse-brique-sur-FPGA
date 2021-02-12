library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity test_Moving_colors is 
end  test_Moving_colors;

architecture archi of test_Moving_colors is 
signal clk100: std_logic :='0';
signal reset: std_logic  :='0';
signal RED_OUT,GREEN_OUT,BLUE_OUT : std_logic_vector(3 downto 0);
begin 
label1 : entity work.Moving_colors
         port map (Clk100 ,Reset,
                    RED_OUT,
                    GREEN_OUT,
                    BLUE_OUT
                    );


clk100<= not clk100 after 5 ns;
reset <= '1' after 3 ns; 
end archi;