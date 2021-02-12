library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mode is 
port (clk25,reset: in std_logic;
       pause_rqt: in std_logic;
       endframe: in std_logic;
       lost : in std_logic;
       no_brick : in std_logic;
       
       game_lost: out std_logic;
       brick_win : out std_logic;  
       pause : out std_logic );
end mode;

architecture archi of mode is 
signal raz_tempo_pause :std_logic;
signal update_tempo_pause :std_logic;
signal fin_tempo_pause : std_logic;
signal load_timer_lost : std_logic;
signal update_timer_lost : std_logic;
signal timer_lost:std_logic_vector(5 downto 0) ;
begin 
tempo_pause:   entity work.tempo_pause
               port map(clk25,reset,
                       raz_tempo_pause,
                       update_tempo_pause,
                       fin_tempo_pause);
timerlost :   entity work.timerlost
               port map(clk25,reset,
                       load_timer_lost,
                       update_timer_lost,
                       timer_lost,
                       game_lost);
MAE        :   entity work.MAE
               port map(clk25,reset,
                       pause_rqt,
                       endframe,
                       lost,
                       no_brick ,
                       fin_tempo_pause,
                       timer_lost,
                       brick_win,
                       pause,
                       update_tempo_pause,
                       raz_tempo_pause,
                       load_timer_lost,
                       update_timer_lost); 

end archi ; 










