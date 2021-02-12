library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ClkDiv is 
port(clk100 , reset : in std_logic;
        clk25 : out std_logic );
end ClkDiv;

architecture archi of ClkDiv is 
signal clk25M : std_logic :='0';
signal cpt : std_logic_vector(1 downto 0);
begin 
  process(clk100,reset)
   begin
    if reset='0' then clk25M<='0'; cpt<="01";
    elsif rising_edge(clk100) then 
    cpt<=cpt+1 ; 
    if cpt="10" then clk25M<= not clk25M; cpt<="01";
    end if;
    end if; 
    end process; 
    clk25<=clk25M;
end archi;
