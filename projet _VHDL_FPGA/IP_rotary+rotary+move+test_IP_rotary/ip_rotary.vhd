----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
--	IP Gestion du Codeur Rotatif pour Casse-Briques
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ip_rotary is
    Port ( clk25 			: in STD_LOGIC;	-- Horloge
           reset 			: in STD_LOGIC;	-- Reset Asynchrone
           rot_a 			: in STD_LOGIC;	-- Switch A du Codeur
           rot_b 			: in STD_LOGIC;	-- Switch B du Codeur
			  rot_left 		: out STD_LOGIC;	-- Commande Rotation a Gauche
           rot_right 	: out STD_LOGIC);	-- Commande Rotation a Droite
end ip_rotary;

architecture Behavioral of ip_rotary is

-- Pour Interconnexion des Deux Sous-Blocs
signal qa,qb: std_logic;

begin

	-- Instanciation Sous-Modules

	-- Gestion des Signaux du Codeur Rotatif
	codeur: entity work.rotary
		port map (
			clk25 		=> clk25,		-- Horloge
			reset 		=> reset,		-- Reset Asynchrone
			rot_a	 		=> rot_a,		-- Switch A du Codeur
			rot_b 		=>	rot_b,		-- Switch B du Codeur
			qa 			=> qa,			-- Comportement du Switch A (Filtre)
			qb 			=> qb);			-- Comportement du Switch B (Filtre)
    
	-- Generation des Commandes de Rotation
	---------------------------------------------------------------------
	-- REMPLACER CES 2 INSTRUCTIONS PAR L'INSTANCIATION DU MODULE MOVE --
	instance:  entity work.move(archi)
                   port map(
                        clk25 => clk25,
                        reset => reset,
                        qa => qa,
                        qb => qb,
                        rot_left => rot_left,
                        rot_right=> rot_right);
	---------------------------------------------------------------------

end Behavioral;

