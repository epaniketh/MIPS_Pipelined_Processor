-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/28/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Orgate is
	port (    a : IN STD_LOGIC;
		  b : IN STD_LOGIC;
		  PCSrc_Jump : OUT STD_LOGIC);
end Orgate;

architecture behavioral of Orgate is
begin
PCSrc_Jump <= a or b;
end behavioral;
