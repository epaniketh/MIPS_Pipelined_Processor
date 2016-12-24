LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Concatenation is
	port (    a : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
		  b : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	          PCJumpD : OUT STD_LOGIC_VECTOR (31 downto 0));
end Concatenation;

architecture behavioral of Concatenation is
begin
PCJumpD <= (b(31 downto 28) & a);
end behavioral;
