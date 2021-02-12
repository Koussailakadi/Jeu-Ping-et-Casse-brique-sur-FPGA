library ieee;
use ieee.std_logic_1164.All;
use ieee.std_logic_unsigned.ALL;

entity MAE_moving_colors is 
port(clk100,reset : in std_logic;
     RED_out : in std_logic_vector(3 downto 0);
     GREEN_out : in std_logic_vector(3 downto 0);
     BLUE_out : in std_logic_vector(3 downto 0);
     inc_r , dec_r : out std_logic;
     inc_g , dec_g : out std_logic;
     inc_b , dec_b : out std_logic);
end MAE_moving_colors ;

architecture archi of MAE_moving_colors is 
type etat is (E0,E1,E2);
signal EP,EF :etat;
begin 
--registre d'etat : 
process (clk100,reset)
begin 
if reset = '0' then EP<=EP;
elsif rising_edge(clk100) then EP<=EF;
end if;
end process; 
--combinatoire des entrées et sorties: 
process(EP,RED_out,GREEN_out,BLUE_out)
begin 
case (EP) is 
    when E0 => inc_r <='0';dec_r<='1';inc_g<='1';dec_g<='0';inc_b<='0';dec_b<='0';
               if RED_out = "0000" then 
                   if GREEN_out="1111" then EF<=E1; end if;
               else EF<=E0;
               end if;
    when E1 => inc_r <='0';dec_r<='0';inc_g<='0';dec_g<='1';inc_b<='1';dec_b<='0';
               if GREEN_out="0000" then 
                  if BLUE_out="1111" then EF<=E2; end if;
               else EF<=E1;
               end if;
    when E2 => inc_r <='1';dec_r<='0';inc_g<='0';dec_g<='0';inc_b<='0';dec_b<='1';
               if BLUE_out ="0000" then
                   if RED_out= "1111" then EF<=E0; end if;
               else EF<=E2;
               end if;
 end case;

end process;

end archi;