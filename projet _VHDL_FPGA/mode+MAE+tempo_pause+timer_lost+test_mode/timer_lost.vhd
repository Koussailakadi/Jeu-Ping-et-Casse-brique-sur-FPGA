library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity timerlost is 
port (clk25,reset: in std_logic;
      load_timer_lost : in std_logic;
      update_timer_lost : in std_logic;
      timer_lost : out std_logic_vector(5 downto 0);
      game_lost : out std_logic    );
end timerlost ;
architecture archi of timerlost is 
signal cpt : std_logic_vector(5 downto 0);
signal com : std_logic_vector(1 downto 0);
begin 

--identification de la condition com
com<=load_timer_lost&update_timer_lost;
--registe  du compteur 
process(clk25,reset)
begin 
if reset='0' then cpt<=(others=>'0');
elsif rising_edge(clk25) then 
  case(com) is 
     when "00" => cpt<=cpt;
     when "01" => cpt<=cpt-1;
     when "10" => cpt<="111111";
     when "11" => cpt<="111111";
     when others => null;
  end case;
end if;
end process;
timer_lost<=cpt;
game_lost<= not ((not cpt(5)) and (not cpt(4)) and (not cpt(3)) and (not cpt(2)) and (not cpt(1)) and (not cpt(0)));
end archi; 