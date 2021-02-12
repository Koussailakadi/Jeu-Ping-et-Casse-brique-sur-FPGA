library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity clkDiv10M is 
port(reset,clk100 : in std_logic;
     clk10MHz: out std_logic);
end  clkDiv10M;

architecture archi of clkDiv10M is 
signal cpt: std_logic_vector(2 downto 0):=(others=> '0'); -- compteur pour 10 Mhz avec periode de 100ns
signal cpt20Hz: std_logic_vector(22 downto 0):=(others=> '0'); -- compteur pour 20Hz de 50ms donc pour visualiser il faut 
signal clk10MHz_tmp : std_logic :='0';                           --mettre le pas de simulation
signal clk20Hz_tmp : std_logic :='0';

begin 
 process(reset,clk100)
 begin 
  if reset='0' then clk10MHz_tmp<='0';clk20Hz_tmp <='0';
  elsif rising_edge(clk100) then cpt<=cpt+1;cpt20Hz<=cpt20Hz+1;
  if cpt=4 then clk10MHz_tmp<= not clk10MHz_tmp; cpt<=(others=>'0') ; end if;
  if cpt20Hz=2499999 then clk20Hz_tmp<=not clk20Hz_tmp; cpt20Hz<=(others=>'0'); end if; --pour faire une horloge de 20HZ 
                                                                                        --il suffit juste de déclarer clk20 comme sortie
                                                                                        --et la brancher au signal clk20Hz_tmp 
  end if;
 end process;
clk10MHz<=clk10MHz_tmp;
end archi;