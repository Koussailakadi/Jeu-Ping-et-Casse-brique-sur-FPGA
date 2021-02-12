library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity Moving_colors is 
              port (Clk100 ,reset  : in std_logic;
                    RED_OUT : out std_logic_vector(3 downto 0);
                    GREEN_OUT : out std_logic_vector(3 downto 0);
                    BLUE_OUT : out std_logic_vector(3 downto 0)
                    );
end Moving_colors;

architecture archi of Moving_colors is 
signal clk10 : std_logic;
signal RED_out_tmp, GREEN_out_tmp, BLUE_out_tmp :std_logic_vector(3 downto 0);
signal inc_r , dec_r, inc_g , dec_g ,inc_b , dec_b : std_logic;
begin 
clk10_MHZ : entity work.clkDiv10M
           port map (reset,clk100,clk10);

MAE :      entity work.MAE_moving_colors
           port map (clk100,reset,
                     RED_out_tmp,
                     GREEN_out_tmp,
                     BLUE_out_tmp,
                     inc_r , dec_r,
                     inc_g , dec_g,
                     inc_b , dec_b);

compteurs : entity work.compteur_moving_colors
           port map(clk10,reset,
                    inc_r , dec_r,
                    inc_g , dec_g,
                    inc_b , dec_b,
                    RED_out_tmp,
                    GREEN_out_tmp,
                    BLUE_out_tmp);

RED_OUT<=RED_out_tmp;
GREEN_OUT<=GREEN_out_tmp;
BLUE_OUT<=BLUE_out_tmp;

end archi; 