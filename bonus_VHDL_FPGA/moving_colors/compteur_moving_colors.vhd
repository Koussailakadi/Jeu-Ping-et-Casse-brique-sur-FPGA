library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity compteur_moving_colors is 
port(clk10,reset : in std_logic;
     inc_r , dec_r :in std_logic;
     inc_g , dec_g : in std_logic;
     inc_b , dec_b : in std_logic;
     RED_out : out std_logic_vector(3 downto 0);
     GREEN_out : out std_logic_vector(3 downto 0);
     BLUE_out : out std_logic_vector(3 downto 0));
end compteur_moving_colors;

architecture archi of compteur_moving_colors is 
signal cpt_r : std_logic_vector(4 downto 0);
signal cpt_g : std_logic_vector(4 downto 0);
signal cpt_b : std_logic_vector(4 downto 0);
signal mod_r : std_logic_vector(2 downto 0);
signal mod_g : std_logic_vector(2 downto 0);
signal mod_b : std_logic_vector(2 downto 0);
begin 
--compteur de la couleur rouge :
mod_r<=reset&inc_r&dec_r;
process(clk10,mod_r)
begin 
if reset='0' then cpt_r<=(others=>'0');
elsif rising_edge(clk10) then 
   case(mod_r) is 
     when "000" => cpt_r<=(others=>'1');  -- initialisation 
     when "100" => cpt_r<=cpt_r;   -- mémorisation 
     when "110" => cpt_r<=cpt_r+1; -- incrémentation 
     when "101" => cpt_r<=cpt_r-1; -- décrémentation
     when others=> NULL;
   end case;
end if; 
end process;

--compteur de la couleur verte
mod_g<=reset&inc_g&dec_g;
process(clk10,mod_g)
begin 
if reset='0' then cpt_g<=(others=>'0');
elsif rising_edge(clk10) then 
   case(mod_g) is 
     when "000" => cpt_g<=(others=>'1');  -- initialisation 
     when "100" => cpt_g<=cpt_g;   -- mémorisation 
     when "110" => cpt_g<=cpt_g+1; -- incrémentation 
     when "101" => cpt_g<=cpt_g-1; -- décrémentation
     when others=> NULL;
   end case;
end if; 
end process;

--compteur de la couleur blue
mod_b<=reset&inc_b&dec_b;
process(clk10,mod_b)
begin 
if reset='0' then cpt_b<=(others=>'0');
elsif rising_edge(clk10) then 
   case(mod_b) is 
     when "000" => cpt_b<=(others=>'1');  -- initialisation 
     when "100" => cpt_b<=cpt_b;   -- mémorisation 
     when "110" => cpt_b<=cpt_b+1; -- incrémentation 
     when "101" => cpt_b<=cpt_b-1; -- décrémentation
     when others=> NULL;
   end case;
end if; 
end process;
-----------------------------
RED_out<=cpt_r(4 downto 1);
GREEN_out<=cpt_g(4 downto 1);
BLUE_out<=cpt_b(4 downto 1);

end archi; 