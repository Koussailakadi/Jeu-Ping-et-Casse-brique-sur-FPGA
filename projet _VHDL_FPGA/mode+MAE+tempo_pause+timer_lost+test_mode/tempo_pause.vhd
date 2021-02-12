library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity tempo_pause is 
port(clk25,reset: in std_logic;
     raz_tempo_pause:in std_logic;
     update_tempo_pause: in std_logic;
     fin_tempo_pause : out std_logic );
end tempo_pause ;

architecture archi of tempo_pause is 
signal cpt: std_logic_vector(9 downto 0) ;
signal com :std_logic_vector(1 downto 0);

begin
-- definition de com
com<=raz_tempo_pause&update_tempo_pause;
--le registre du compteur 
process(clk25,reset,com)
begin
if reset='0' then cpt<=(others=>'0');
elsif rising_edge(clk25) then 

  case (com) is 
     when "00" => cpt<=cpt;
     when "01" => cpt<=cpt+1;
     when "10" => cpt<=(others=>'0');
     when "11" => cpt<=(others=>'0');
     when others => null;
  end case;
end if;
fin_tempo_pause<=cpt(9) and cpt(8) and cpt(7) and cpt(6) and cpt(5) and cpt(4) and cpt(3) and cpt(4) and cpt(2) and cpt(1) and cpt(0);
end process;

end archi; 