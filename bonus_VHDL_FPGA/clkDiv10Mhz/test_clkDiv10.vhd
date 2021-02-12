library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity test_clkDiv10M is 
end  test_clkDiv10M;

architecture archi of test_clkDiv10M is 
signal clk100: std_logic :='0';
signal reset: std_logic  :='0';
signal clk10 : std_logic;
begin 
label1 : entity work.clkDiv10M
         port map(reset,clk100,clk10);


clk100<= not clk100 after 5 ns;
reset <= '1' after 3 ns; 
end archi;