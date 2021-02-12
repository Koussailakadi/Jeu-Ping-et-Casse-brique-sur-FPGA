library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity test_compteur_moving_colors is 
end test_compteur_moving_colors;

architecture archi of  test_compteur_moving_colors is 
signal clk10 : std_logic := '0';
signal reset :std_logic :='0';
signal inc_r,dec_r: std_logic;
signal inc_g , dec_g :std_logic;
signal inc_b , dec_b :std_logic;
signal RED_out : std_logic_vector(3 downto 0);
signal GREEN_out : std_logic_vector(3 downto 0);
signal BLUE_out : std_logic_vector(3 downto 0);
begin 
labl1 : entity work.compteur_moving_colors
        port map(clk10,reset,
                 inc_r , dec_r,
                 inc_g , dec_g ,
                 inc_b , dec_b ,
                 RED_out ,
                 GREEN_out ,
                 BLUE_out);



clk10<=not clk10 after 50 ns;
reset<= '1' after 1 ns;
inc_r<='1' , '0' after 2000 ns;
dec_r <='0' , '1' after 2100 ns ;
inc_g<='1' , '0' after 1000 ns;
dec_g <='0' , '1' after 1250 ns ;
inc_b<='1' , '0' after 800 ns;
dec_b <='0' , '1' after 2100 ns;
end archi;