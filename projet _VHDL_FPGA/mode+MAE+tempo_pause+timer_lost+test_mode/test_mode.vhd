library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_mode is 
end test_mode;

architecture archi of test_mode is  
signal  clk25,reset:  std_logic :='0';
signal  pause_rqt:  std_logic;
signal  endframe:  std_logic;
signal  lost :  std_logic;
signal  no_brick : std_logic;       
signal  game_lost:  std_logic;
signal  brick_win :  std_logic;  
signal  pause :  std_logic ;
begin 
--instanciation 
instance : entity work.mode
           port map(clk25,reset,
                pause_rqt,
                endframe,
                lost,
                no_brick,
                         ---- sorties 
                game_lost,
                brick_win, 
                pause);

--signaux d'entées:
pause_rqt<='0', '1' after 50 ns, '0' after 100 ns , '1' after 450 ns, '0' after 500 ns;
no_brick<='0', '1' after 42000 ns;
lost<='0', '1' after 400 ns, '0' after 50000 ns; 
endframe<='0','1' after 500 ns;
clk25<= not clk25 after 20 ns;
reset<= '1' after 5 ns;
end archi;