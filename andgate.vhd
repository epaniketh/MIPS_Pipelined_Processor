-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/22/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity andgate is
	port (    a : IN STD_LOGIC;
		  b : IN STD_LOGIC;
		  PCSrcD : OUT STD_LOGIC);
end andgate;

architecture behavioral of andgate is
begin
PCSrcD <= a and b;
end behavioral;

