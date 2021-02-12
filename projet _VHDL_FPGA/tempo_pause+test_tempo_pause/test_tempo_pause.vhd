library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_tempo_pause is 
end test_tempo_pause ;

architecture archi of test_tempo_pause is 
signal clk25,reset: std_logic := '0';
signal raz_tempo_pause : std_logic;
signal update_tempo_pause : std_logic;
signal fin_tempo_pause :std_logic;
signal count : std_logic_vector(9 downto 0) ;
begin 
instance: entity work.tempo_pause 
          port map(clk25,reset,raz_tempo_pause,update_tempo_pause,fin_tempo_pause);

clk25<=not clk25 after 20 ns;
reset<='1' after 5 ns;
raz_tempo_pause<='0','1' after 200  ns, '0' after 300 ns;
update_tempo_pause<='0', '1'  after 20 ns , '0' after 500 ns, '1' after 600 ns;
end archi;