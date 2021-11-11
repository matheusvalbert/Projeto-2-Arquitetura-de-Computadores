library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

ENTITY PC IS
	PORT(
		NextInst	 : IN  STD_LOGIC;
		LoadAddr	 : IN	 STD_LOGIC;
		AddrIn 	 : IN	 STD_LOGIC_VECTOR(7 downto 0);
		Clock     : IN  STD_LOGIC;
		AddrOut	 : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
END ENTITY;

ARCHITECTURE RTL OF PC IS

  SIGNAL count: STD_LOGIC_VECTOR(7 downto 0) := "00000000";
  
BEGIN
 
	PROCESS(Clock, NextInst, LoadAddr)
	BEGIN
		IF rising_edge(Clock) THEN 
			IF NextInst = '1' THEN -- pc = pc + 1
				count <= count + '1';
			ELSIF LoadAddr = '1' THEN -- pc = reg inst.
				count <= AddrIn;
			END IF;
		END IF;
	END PROCESS;

	AddrOut <= count;

END ARCHITECTURE;