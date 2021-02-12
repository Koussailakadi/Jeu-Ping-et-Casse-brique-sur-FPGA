library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity game_mgr is 
port(clk25,reset: in std_logic;
      game_rqt: in std_logic;
      game_type: out std_logic );
end game_mgr ;

architecture archi of game_mgr is 
-- définition des état:
type etat is (E0,E1);
signal EP,EF: etat ;
signal sortie: std_logic;
begin 

--- signal de sortie
game_type<=sortie;

--registre d'etat
 process(clk25,reset)
 begin 
 if reset='0' then EP<=E0;
 elsif rising_edge(clk25) then 
      EP<=EF;
 end if;
 end process;
--combénatoires des etats et sorties
 process(game_rqt,EP)
 begin 
 case(EP) is 
    
   when E0 => sortie<='0';
                   if rising_edge(game_rqt) then EF<=E1;
                   if game_rqt'event and game_rqt='0' then EF<=E0;
                   end if;
                   end if;

   when E1 => sortie<='1';
                   if rising_edge(game_rqt) then EF<=E0;
                   if game_rqt'event and game_rqt='0' then EF<=E0;
                   end if;
                   end if;

           
  end case;
 end process;

end archi;