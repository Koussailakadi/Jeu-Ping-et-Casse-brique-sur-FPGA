library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_game_manager is 
end test_game_manager ;

architecture archi of test_game_manager is
signal clk25,reset : std_logic :='0';
signal game_rqt : std_logic;
signal game_type :std_logic;
begin
instance: entity work.game_mgr
          port map(clk25,reset,game_rqt,game_type);


--les signaux 
game_rqt <='0','1' after 90 ns, '0' after 130 ns , '1' after 290 ns , '0' after 410 ns, '1' after 500 ns;
clk25 <= not clk25 after 20 ns;
reset<='1' after 3 ns;
end archi;