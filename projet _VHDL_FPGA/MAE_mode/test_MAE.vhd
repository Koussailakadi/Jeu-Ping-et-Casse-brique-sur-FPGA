library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_MAE is 
end test_MAE ;

architecture archi of test_MAE is 
--sigaux entrées
signal clk25,reset: std_logic :='0' ;
signal pause_rqt : std_logic;
signal endframe : std_logic;
signal lost : std_logic;
signal no_brick : std_logic;
signal fin_tempo_pause : std_logic;
signal timer_lost : std_logic_vector(5 downto 0);

--signaux sorties
signal brick_win : std_logic;
signal pause : std_logic;
signal update_tempo_pause : std_logic;
signal raz_tempo_pause : std_logic;
signal load_timer_lost : std_logic;
signal update_timer_lost : std_logic;
begin 
instance: entity work.MAE
          port map (clk25,reset,
                    pause_rqt,
                    endframe,
                    lost,
                    no_brick,
                    fin_tempo_pause,
                    timer_lost,

                    brick_win,
                    pause,
                    update_tempo_pause, 
                    raz_tempo_pause,
                    load_timer_lost, 
                    update_timer_lost ); 


--les signaux d'entrées
pause_rqt<='0', '1' after 50 ns, '0' after 100 ns , '1' after 450 ns, '0' after 500 ns;
fin_tempo_pause<='0', '1' after 200 ns, '0' after 240 ns;
no_brick<='0', '1' after 550 ns;
lost<='0', '1' after 400 ns, '0' after 480 ns; 
timer_lost<="000000","111111" after 550 ns ,"000000" after 600 ns;
endframe<='0','1' after 500 ns;
 
clk25<= not clk25 after 20 ns;
reset<= '1' after 5 ns;
end archi;