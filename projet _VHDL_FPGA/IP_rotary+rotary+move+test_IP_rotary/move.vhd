library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity move is 
port (clk25,reset: in std_logic;
       qa,qb: in std_logic;
       rot_left,rot_right:out std_logic
       );
end move;

architecture archi of move is 
--définition des etats
type etat is (E0,E1,E2,E3,E4,E5);
signal EF,EP:etat;
signal r,l : std_logic;
begin 
--process du registre d'etat 
process(clk25,reset)
begin 
if reset='0' then EP<=E0;
elsif rising_edge(clk25) then 
EP<=EF;
end if;
end process;
--combinatoire des etats et des sorties
process(qa,qb,EP)
begin 
case (EP) is 
    when E0 => r<='0';l<='0';
               if qa='1' then 
                   if  qb='1' then EF<=E4;
                   else EF<=E1;
                   end if;
                else EF<=E0;
                end if;    
    when E1 => r<='0';l<='1';
               EF<=E2; 
    when E2 => r<='0';l<='0';
               if qa='0' then 
                   if  qb='1' then EF<=E3;
                   else EF<=E5;
                   end if;
                else EF<=E2;
                end if;    
    when E3 => r<='0';l<='1';
               EF<=E0;
    when E4 => r<='1';l<='0';
               EF<=E2;
    when E5 => r<='1';l<='0';
               EF<=E0;
  end case;
end process;
rot_left<=l;
rot_right<=r;
end archi ;




 
