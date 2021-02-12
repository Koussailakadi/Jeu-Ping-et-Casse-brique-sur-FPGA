----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
--
--	Gestion des Signaux du Codeur Rotatif
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rotary is
    Port ( clk25			: in std_logic;	-- Horloge, Reset Asynchrone
			  reset			: in std_logic;	-- Horloge, Reset Asynchrone
			  rot_a 			: in std_logic;	-- Switch A du Codeur
           rot_b 			: in std_logic;	-- Switch B du Codeur
			  qa 				: out std_logic;	-- Comportement du Switch A (Filtre)
           qb 				: out std_logic);	-- Comportement du Switch B (Filtre)
end rotary;

architecture Behavioral of rotary is

-- Signaux pour Echantillonage des Switchs A et B
signal echa,echb: std_logic;
signal ech: std_logic_vector(1 downto 0);

begin

------------------------------------------------------------
-- ECHANTILLONNAGE DES SIGNAUX DE L'ENCODEUR
	process(clk25,reset)

		begin
	
			if reset = '0' then 
				
				echa	<=	'0'; 
				echb	<=	'0'; 
			
			elsif rising_edge(clk25) then
		
				echa	<=	rot_a;
				echb	<=	rot_b;
		
			end if;
	
	end process;

	-- Valeurs Echantillonnees des Switchs en 1 Vecteur
	ech <= echb & echa;

--------------------------------------------------------------

-- FILTRAGE DES SIGNAUX A ET B DU CODEUR
	process (clk25,reset)

		begin
			
			if reset = '0' then 
			
				qa	<=	'0'; 
				qb	<=	'0';
		
			elsif rising_edge(clk25) then
		
				-- Comportement du Switch A
					-- Ne passe à 1 que si Switch B est a 1 aussi
					-- Ne passe à 0 que si Switch B est a 0 aussi
				if ech = "11" then 
					qa	<=	'1';
				elsif	ech = "00" then 
					qa<='0';
				end if;

				-- Comportement du Switch B
					-- Ne passe à 1 que si Switch A est a 0 aussi
					-- Ne passe à 0 que si Switch A est a 1 aussi
				if ech = "01" then 
					qb	<=	'0';
				elsif ech = "10" then 
					qb	<=	'1';
				end if;

			end if;
		end process;
  
end Behavioral;

