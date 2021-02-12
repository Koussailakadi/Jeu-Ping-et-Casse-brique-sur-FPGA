----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Diviseur d'Horloge : 100 MHz --> 25 MHz et 25 Hz
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClkDiv is
    Port ( clk100,reset : in  STD_LOGIC;	-- Horloge 100 Mhz et Reset Asynchrone
           clk25 : out  STD_LOGIC);			-- Horloge 25 MHz
end ClkDiv;

architecture Behavioral of ClkDiv is

-- Compteur pour Horloge 25 MHz
signal CPT_25M: std_logic_vector(1 downto 0);

begin

-- Affectation Horloge 25 MHz
clk25<=CPT_25M(1);

--------------------------------------------
-- GESTION DES COMPTEURS DE DIVISION
--		ET GENERATION DE L'HORLOGE 25 Hz
process(clk100,reset)

	begin
	
		if reset = '0' then 
		
			CPT_25M <= "00"; 

		elsif rising_edge(clk100) then
			
			CPT_25M <= CPT_25M + 1;
		
		end if;

end process;
	

end Behavioral;
