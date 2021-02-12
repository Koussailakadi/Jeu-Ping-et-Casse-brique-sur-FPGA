----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Controleur du Jeu
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pong_pack.ALL;


entity game is
	Port(
			clk25 : in  STD_LOGIC;										-- Horloge
         reset : in  STD_LOGIC;										-- Reset Asynchrone
         
			-- SELECTION MODE PAUSE
			master_slave_rqt: in STD_LOGIC;							-- Demande Changement de Mode Console / Manette
			game_rqt: in STD_LOGIC;										-- Demande Changement de Jeu (Pong ou Casse Briques)
			pause_rqt: in STD_LOGIC;									-- Demande de Pause = Appui Bouton Encodeur
			
			-- PARAMETES IMAGE
			endframe : in  STD_LOGIC;									-- Fin de l'Image Visible
         visible : in  STD_LOGIC;									-- Zone Visible de l'Image
         
			-- OBJETS DES JEUX
			wall_pong : in  STD_LOGIC;									-- Pixel Courant = Mur Jeu Pong
         wall_brick : in  STD_LOGIC;								-- Pixel Courant = Mur Jeu Casse Briques
         barrier: in STD_LOGIC;										-- Pixel Courant = Obstacle (Jeu Pong)
			bluebox : in  STD_LOGIC;									-- Pixel Courant = Case Bleue
			pad : in  STD_LOGIC;											-- Pixel Courant = Raquette
         ball : in  STD_LOGIC;										-- Pixel Courant = Balle
			brick : in  tableau;											-- Pixel Courant = Brique
         lost : in  STD_LOGIC;										-- La Balle Va Sortir de l'Ecran
         
			brick_bounce : in tableau;									-- Rebond Contre une Brique
         
			-- COULEUR A AFFICHER
			red : out  STD_LOGIC;										-- Affichage Rouge
         green : out  STD_LOGIC;										-- Affichage Vert
         blue : out  STD_LOGIC;										-- Affichage Bleu
         
			-- ACTIONS SUR LE JEU
			master_slave: out STD_LOGIC;								-- Type de Mode (0 = Manette / 1 = Console)
			game_type: out STD_LOGIC;									-- Type de Jeu (0 = Casse Briques / 1 = Pong)
         pause : out STD_LOGIC;										-- Mode Pause
			game_lost : out STD_LOGIC);								-- Partie Perdue

end game;

architecture Behavioral of game is

signal mas_sla : STD_LOGIC;		-- Signal Interne (Master/Slave)
signal brick_win : STD_LOGIC;		-- Partie Gagnee
signal lost_game : STD_LOGIC;		-- Partie Perdue
signal no_brick: STD_LOGIC;		-- Actif si Toutes les Briques Ont Ete Cassees

begin
	
	---------------------------------------------------------------------
	-- GESTION DU DRAPEAU NO_BRICK (PLUS DE BRIQUES A CASSER)
	process(brick_bounce)

		begin
	
			-- Si on Trouve une Brique Non Cassee
				-- NoBrick Reste a 0
				-- Sinon, NoBrick Passe a 1
			no_brick<='1';
				
			for i in 0 to 1 loop
				for j in 0 to 8 loop
					if brick_bounce(i)(j) = '0' then 
						no_brick<='0';
					end if;
				end loop;
			end loop;
	end process;
	---------------------------------------------------------------------


	-- SELECTION DES COULEURS DEX PIXELS
	color_select: entity work.display
			port map (
				visible 			=> visible,		-- Zone Visible de l'Image
				master_slave	=> mas_sla,		-- Mode Console ou Manette
				pad 				=> pad,			-- Pixel Courant = Raquette
				wall_pong 		=> wall_pong,	-- Pixel Courant = Mur Jeu Pong
				wall_brick 		=> wall_brick,	-- Pixel Courant = Mur Jeu Casse Briques
				barrier			=> barrier,		-- Pixel Courant = Obstacle (Jeu Pong)
				bluebox 			=> bluebox,		-- Pixel Courant = Case Bleue
				ball				=> ball,			-- Pixel Courant = Balle
				brick 			=> brick,		-- Pixel Courant = Brique
				brick_win 		=> brick_win,	-- Partie Gagnee
				lost_game		=> lost_game,	-- Partie Perdue
				red 				=> red,			-- Affichage Rouge
				green 			=> green,		-- Affichage Vert
				blue 				=> blue			-- Affichage Bleu
			);


	-- CONTROLEUR DES JEUX CASSE BRIQUES ET PONG
	-------------------------------------------------------------------
	-- REMPLACER CES 3 INSTRUCTIONS PAR L'INSTANCIATION DU MODULE MODE --

	pause <= not pause_rqt;
	lost_game <= '0';
	brick_win <= '0';
	-------------------------------------------------------------------


	-- NE PAS TOUCHER A CETTE INSTRUCTION
	game_lost <= lost_game;


	-- SELECTION DU JEU
	-----------------------------------------------------------------------------
	-- REMPLACER CETTE INSTRUCTION PAR L'INSTANCIATION DU MODULE GAME MANAGER --

        game_manger:         entity work.game_mgr
                             port map(clk25=>clk25,
                                      reset=>reset,
                                      game_rqt=>game_rqt,
                                      game_type=>game_type);
	------------------------------------------------------------------------------


	-- SELECTION DU MODE CONSOLE/MANETTE
	master_slave_select: entity work.master_slave_mgr
			port map (
				clk25					=> clk25,				-- Horloge 25 MHz
				reset					=> reset,				-- Reset Asynchrone
				master_slave_rqt	=> master_slave_rqt,	-- Demande de Changement de Mode
				master_slave		=> mas_sla				-- Mode de Fonctionnement (Manette / Console)
			);

	master_slave <= mas_sla;

end Behavioral;

