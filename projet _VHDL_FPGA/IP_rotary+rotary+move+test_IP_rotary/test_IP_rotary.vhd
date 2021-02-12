library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_IP_rotary is
 
end test_IP_rotary;

architecture archi of test_IP_rotary is 
signal clk25,reset: std_logic :='0';
signal rot_a,rot_b: std_logic;
signal rot_left,rot_right :std_logic;

begin
instance: entity work.ip_rotary 
          port map(clk25,reset,rot_a,rot_b,rot_left,rot_right); 


clk25<=not clk25 after 20 ns ; 
reset<='1' after 3 ns;

--test rot_left comme sur la fiche de TP 
rot_a<='0','1' after 90 ns , '0' after 290 ns , '1' after 410 ns;
rot_b<='0','1' after 130 ns, '0' after 340 ns , '1' after 520 ns;

end archi;     
  

