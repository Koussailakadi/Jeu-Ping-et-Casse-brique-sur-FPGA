library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_move is
 
end test_move;

architecture archi of test_move is 
signal clk25,reset: std_logic :='0';
signal qa,qb: std_logic;
signal rot_left,rot_right :std_logic;
signal xa,xb: std_logic;
begin
instance1: entity work.move
          port map(clk25,reset,qa,qb,rot_left,rot_right); 

--instance2: entity work.move
--          port map(clk25,reset,xa,xb,rot_left,rot_right); 

clk25<=not clk25 after 20 ns ; 
reset<='1' after 3 ns;

--test rot_left comme sur la fiche de TP 
qa<='0','1' after 90 ns , '0' after 290 ns , '1' after 410 ns;
qb<='0','1' after 130 ns, '0' after 340 ns , '1' after 520 ns;

--test rot_right comme sur la fiche de TP 
--xa<='0','1' after 130 ns , '0' after 345 ns , '1' after 490 ns;
--xb<='0','1' after 90 ns, '0' after 230 ns , '1' after 420 ns;
end archi;     
  


