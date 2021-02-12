----------------------------------------------------------------------------------
-- Company: 	UPMC
-- Engineer: 	Julien Denoulet
-- 
--	Selection du Mode de la Console (Maitre/Esclave)
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity master_slave_mgr is
    Port ( clk25 : in  STD_LOGIC;				-- Horloge 25 MHz
           reset : in  STD_LOGIC;				-- Reset Asynchrone
           master_slave_rqt : in  STD_LOGIC;	-- Demande de Changement de Mode Master / Slave
           master_slave : out  STD_LOGIC);	-- Indicateur Manette / Console
end master_slave_mgr;

architecture Behavioral of master_slave_mgr is

-- Etats de la MAE
type etat is (MASTER, CHANGE_2_SLAVE, SLAVE, CHANGE_2_MASTER);

signal EP, EF: etat;	-- Signaux Etat Present et Futur

-- MASTER_SLAVE = 0
	-- Mode Esclave / Manette
		-- Pas d'Affichage VGA
		-- Pas de Reception de Donnees via le RS232

-- MASTER_SLAVE = 1
	-- Mode Maitre / Console
		-- Affichage VGA Activé
		-- Pas d'Emission de Donnees via le RS232

begin

	-- REGISTRE D'ETAT DE LA MAE
	process(clk25,reset)
	
	begin
	
		if reset = '0' then
			EP <= MASTER;
		elsif rising_edge(clk25) then
			EP <= EF;
		end if;
	
	end process;


	-- EVOLUTION DE LA MAE
	process(EP,master_slave_rqt)
	
	begin
	
		case (EP) is
		
			-- Dans l'etat MASTER
				-- Le FPGA Est en Mode Console
				-- Tant qu'On N'A Pas de Demande de Changement
			when MASTER				=>	master_slave <= '1'; EF <= MASTER;
											if master_slave_rqt = '1' then
												EF <= CHANGE_2_SLAVE;
											end if;

			-- Dans l'etat CHANGE_2_SLAVE
				-- On Passe en Mode Manette
				-- On Reste dans l'Etat Tant que la Requete de Changement Est Maintenue
			when CHANGE_2_SLAVE 	=> master_slave <= '0'; EF <= CHANGE_2_SLAVE;
											if master_slave_rqt = '0' then
												EF <= SLAVE;
											end if;

			-- Dans l'etat SLAVE
				-- Le FPGA Est en Mode Manette
				-- Tant qu'On N'A Pas de Demande de Changement
			when SLAVE 				=> master_slave <= '0'; EF <= SLAVE;
											if master_slave_rqt = '1' then
												EF <= CHANGE_2_MASTER;
											end if;

			-- Dans l'etat CHANGE_2_MASTER
				-- On Passe en Mode Console
				-- On Reste dans l'Etat Tant que la Requete de Changement Est Maintenue
			when CHANGE_2_MASTER	=> master_slave <= '1'; EF <= CHANGE_2_MASTER;
											if master_slave_rqt = '0' then
												EF <= MASTER;
											end if;

		end case;
	end process;

end Behavioral;

