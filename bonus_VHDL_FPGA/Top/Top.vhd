----------------------------------------------------------------------------------
-- Company: Sorbonne Université
-- Engineer: Julien Denoulet
-- 
-- Générateur de Couleurs
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top is
    Port ( Clk100 : in STD_LOGIC;                       -- Horloge 100 MHz
       Reset : in STD_LOGIC;                            -- Reset Asynchrone
       VGA_Red : out STD_LOGIC_VECTOR (3 downto 0);     -- Composante Rouge de la Couleur VGA Affichée
       VGA_Green : out STD_LOGIC_VECTOR (3 downto 0);   -- Composante Verte de la Couleur VGA Affichée
       VGA_Blue : out STD_LOGIC_VECTOR (3 downto 0);    -- Composante Bleue de la Couleur VGA Affichée
       HSync : out STD_LOGIC;                           -- Synchro Horizontale VGA
       VSync : out STD_LOGIC);                          -- Synchro Verticale VGA
end Top;

architecture Behavioral of Top is

signal Clk25: std_logic;                            -- Horloge 25 MHz
signal Reset_N: std_logic;                          -- Reset Actif Bas

signal Red : STD_LOGIC_VECTOR (3 downto 0);         -- Commande de Couleur Rouge (Ne Garder que les 4 MSB)
signal Green : STD_LOGIC_VECTOR (3 downto 0);       -- Commande de Couleur Verte (Ne Garder que les 4 MSB)
signal Blue : STD_LOGIC_VECTOR (3 downto 0);        -- Commande de Couleur Bleue (Ne Garder que les 4 MSB)

signal Visible,Endframe: std_logic;
signal XPos,YPos: std_logic_vector(9 downto 0);

begin

    Reset_N <= not Reset;                       -- Reset Actif Bas

    -- Diviseur Horloge 100 MHz --> 25 Mhz
    Diviseur:   entity work.ClkDiv
                port map(
                    clk100 => Clk100,   -- Horloge 100 Mhz
                    reset => Reset_N,   -- Reset Asynchrone
                    clk25 => Clk25      -- Horloge 25 MHz
                );


    -- Générateur de Couleurs Variables Au Fi ldu Temps
    ColorGen:   entity work.Moving_Colors
                port map(
                    Clk100      => Clk100,  -- Horloge 100 Mhz
                    reset       => Reset_N, -- Reset Asynchrone
                    RED_OUT     => Red,     -- Consigne Couleur Rouge
                    GREEN_OUT   => Green,   -- Consigne Couleur Verte
                    BLUE_OUT    => Blue     -- Consigne Couleur Bleue
                );

    -- Contrôleur VGA 4 Bits
    VGA:        entity work.VGA_4bits
                port map(
                    clk25 => Clk25,         -- Horloge
                    reset => Reset_N,       -- Reset Asynchrone
                    r => Red,               -- Commande de Couleur Rouge
                    g => Green,             -- Commande de Couleur Verte
                    b => Blue,              -- Commande de Couleur Bleue
                    red => VGA_Red,         -- Affichage Couleur Rouge vers Ecran VGA
                    green => VGA_Green,     -- Affichage Couleur Verte vers Ecran VGA
                    blue => VGA_Blue,       -- Affichage Couleur Bleue vers Ecran VGA
                    hsync => HSync,         -- Synchro Ligne
                    vsync => VSync,         -- Synchro Trame
                    visible => Visible,     -- Partie Visible de l'Image
                    endframe => Endframe,   -- Dernier Pixel Visible d'une Trame
                    xpos => XPos,           -- Coordonnée X du Pixel Courant
                    ypos => YPos            -- Coordonnee Y du Pixel Courant
                );

end Behavioral;
