LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY REG8 IS
	PORT (
		D					: IN  STD_LOGIC_VECTOR(7 downto 0);
		data_set			: IN	STD_LOGIC_VECTOR(7 downto 0);
		Reset1, Clock1 : IN  STD_LOGIC;
		set, Load 		: IN  STD_LOGIC;
		Q 					: OUT STD_LOGIC_VECTOR(7 downto 0)
	);
END ENTITY;

ARCHITECTURE RTL OF REG8 IS
BEGIN
	PROCESS(Reset1, Clock1, Load, set, data_set)
	BEGIN
		IF Reset1 = '1' THEN -- reset
			Q <= "00000000";
		ELSIF rising_edge(Clock1) THEN
			IF Load = '1' THEN
				Q <= D;
			ELSIF set = '1' THEN -- set reg8 inicializar registrador
				Q <= data_set;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;