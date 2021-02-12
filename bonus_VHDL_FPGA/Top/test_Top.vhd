library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity test_top is 
end test_top;

architecture archi of test_top is 
signal clk100: std_logic :='0';
signal Reset: std_logic :='1';
signal VGA_Red,VGA_Green ,VGA_Blue  : std_logic_vector(3 downto 0);
signal HSync,VSync: std_logic;
begin 

top : entity work.Top 
      port map(Clk100,                      -- Horloge 100 MHz
               Reset ,                           -- Reset Asynchrone
               VGA_Red ,  -- Composante Rouge de la Couleur VGA Affichée
               VGA_Green ,  -- Composante Verte de la Couleur VGA Affichée
               VGA_Blue , -- Composante Bleue de la Couleur VGA Affichée
               HSync ,                 -- Synchro Horizontale VGA
               VSync);                          -- Synchro Verticale VGA


clk100<=not clk100 after 5 ns;
Reset<= '0' after 3 ns;
end archi;