library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

ENTITY ALU IS 
	PORT (        
		op		: IN 	STD_LOGIC;
		A		: IN 	STD_LOGIC_VECTOR(7 downto 0);
		B		: IN 	STD_LOGIC_VECTOR(7 downto 0);
		res	: OUT STD_LOGIC_VECTOR(7 downto 0);
		z		: OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE RTL OF ALU IS

	SIGNAL result : STD_LOGIC_VECTOR(7 downto 0);

BEGIN

	result <= A + B WHEN op = '1' ELSE A - B; -- add ou sub
	res <= result;
	z <= '1' WHEN result = "00000000" ELSE '0'; -- zero check

END ARCHITECTURE;