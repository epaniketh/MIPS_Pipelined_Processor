-- Company: 
-- Engineer: Aniketh Esamudra Prakash
-- 
-- Create Date:     02/24/2016 
-- Design Name: Pipelined_Processor
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity pc is
	port (    d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		  reset : IN STD_LOGIC;
		  StallF : IN STD_LOGIC;
	          clk : IN STD_LOGIC;
	          pc_out : OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
end pc;

architecture behavioral of pc is
begin
process(clk)
variable pcout : std_logic_vector(31 downto 0);
begin
if (rising_edge(clk) and reset = '1') then
pc_out <= "00000000000000000000000000000000";
elsif (rising_edge(clk) and clk = '1' and StallF = '0') then
pc_out <= d;
pcout := d;
elsif (rising_edge(clk) and clk = '1' and StallF = '1') then
pc_out <= pcout;
pcout := pcout;
end if;
end process;
end behavioral;

