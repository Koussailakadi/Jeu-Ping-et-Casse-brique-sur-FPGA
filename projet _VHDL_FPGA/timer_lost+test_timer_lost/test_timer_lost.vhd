library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_timer_lost is 
end test_timer_lost ;

architecture archi of test_timer_lost is 
signal clk25,reset: std_logic :='0' ;
signal load_timer_lost : std_logic;
signal update_timer_lost: std_logic;
signal timer_lost: std_logic_vector(5 downto 0);
signal game_lost: std_logic;
begin 
instance: entity work.timerlost
          port map (clk25,reset,load_timer_lost,update_timer_lost,timer_lost,game_lost); 

--les signaux d'entrées
load_timer_lost <= '0' ,'1' after 50 ns, '0' after 100 ns ;
update_timer_lost<='0' ,'1' after 50 ns;
clk25<= not clk25 after 20 ns;
reset<= '1' after 5 ns;
end archi;