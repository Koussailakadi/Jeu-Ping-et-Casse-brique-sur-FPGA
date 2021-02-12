library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MAE is 
port (clk25,reset: in std_logic;
      pause_rqt : in std_logic;
      endframe: in std_logic;
      lost: in std_logic;
      no_brick : in std_logic;
      fin_tempo_pause: in std_logic;
      timer_lost: in std_logic_vector(5 downto 0);

      brick_win: out std_logic;               --a 
      pause: out std_logic;                   --b
      update_tempo_pause: out std_logic;      --c
      raz_tempo_pause: out std_logic;         --d
      load_timer_lost: out std_logic;         --e
      update_timer_lost: out std_logic        --f    
       );
end MAE;

architecture archi of MAE is 
--declaration des etats
type etat is (E0,E1,E2,E3,E4,E5,E6);
signal EF,EP :etat;
signal a,b,c,d,e,f : std_logic; 
begin
--registre d'etat
process(clk25,reset)
begin 
if reset='0' then EP<=E0;
elsif rising_edge(clk25) then 
EP<=EF;
end if;
end process;

-- conbinatoires des entrées sorties:
process(EP,pause_rqt,endframe,lost,no_brick,fin_tempo_pause,timer_lost)
begin 
    case(EP) is 
         when E0 => a<='0'; b<='1'; c<='0' ; d<='1' ;e<='0';f<='0'; 
                    if pause_rqt='1' then EF<=E1; else EF<=E0; end if;
         when E1 => a<='0'; b<='0'; c<='1' ; d<='0' ;e<='0';f<='0';
                    if pause_rqt='0' then 
                    if fin_tempo_pause='1' then EF<=E3;
                    else EF<=E1;
                    end if;
                    end if;
         when E2 => a<='0'; b<='1'; c<='1' ; d<='0' ;e<='0';f<='0'; 
                    if pause_rqt='0' then 
                    if fin_tempo_pause='1' then EF<=E0;
                    else EF<=E2;
                    end if;
                    end if;
         when E3 => a<='0'; b<='0'; c<='0' ; d<='0' ;e<='0';f<='0'; 
                    if pause_rqt='1' then EF<=E2; end if;
                    if lost='0' then 
                       if no_brick='1' then EF<=E4 ; 
                       else EF<=E3;
                       end if; 
                    end if;
                    if lost='1' then 
                       if no_brick='0' then EF<=E5 ; 
                       else EF<=E3;
                       end if; 
                    end if;
          when E4 => a<='1'; b<='0'; c<='0' ; d<='0' ;e<='0';f<='0';
                     EF<=E4;
          when E5 => a<='0'; b<='0'; c<='0' ; d<='0' ;e<='1';f<='0';
                     if endframe='1' then EF<=E6;
                      else EF<=E5;
                     end if;
          when E6 => a<='0'; b<='0'; c<='0' ; d<='0' ;e<='0';f<='1'; 
                     if timer_lost="000000" then EF<=E0 ; 
                     elsif endframe='1' then EF<=E6; 
                     end if;
                                                      
       end case;
end process;
      brick_win<=a;              
      pause<=b;                
      update_tempo_pause<=c;
      raz_tempo_pause<=d;
      load_timer_lost<=e;
      update_timer_lost<=f; 
end archi;







