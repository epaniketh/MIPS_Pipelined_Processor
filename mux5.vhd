-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/23/2016 
-- Design Name: Pipelined_Processor
library ieee;
use ieee.std_logic_1164.ALL;

Entity mux5 is
PORT (  a : IN std_logic_vector (4 DOWNTO 0);
	b : IN std_logic_vector (4 DOWNTO 0);
	y : OUT std_logic_vector(4 DOWNTO 0);
	sel: IN std_logic);
end entity;

architecture behav of mux5 is
begin
y <= a when sel = '1' else b;
end architecture;
