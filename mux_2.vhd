-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/23/2016 
-- Design Name: Pipelined_Processor
library ieee;
use ieee.std_logic_1164.ALL;

Entity mux_2 is
PORT (  a : IN std_logic_vector (31 DOWNTO 0);
	b : IN std_logic_vector (31 DOWNTO 0);
	c : IN std_logic_vector (31 DOWNTO 0);
	y : OUT std_logic_vector(31 DOWNTO 0);
	sel: IN std_logic_vector(1 downto 0));
end entity;

architecture behav of mux_2 is
begin
y <= a when sel = "00" else
     b when sel = "01" else 
     c when sel = "10" else
     "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
end architecture;