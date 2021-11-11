LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY REGISTERS IS
	PORT (
		rs, rt, rd						:	IN		STD_LOGIC_VECTOR(1 downto 0);
		Reset, Clock, regWrite		:	IN		STD_LOGIC;
		Data								: 	IN		STD_LOGIC_VECTOR(7 downto 0);
		set_reg							:	IN		STD_LOGIC;
		set_r0, set_r1					:	IN		STD_LOGIC_VECTOR(7 downto 0);
		set_r2, set_r3					:	IN		STD_LOGIC_VECTOR(7 downto 0);
		rsOut, rtOut					:	OUT	STD_LOGIC_VECTOR(7 downto 0);
		r0_out, r1_out					:	OUT	STD_LOGIC_VECTOR(7 downto 0);
		r2_out, r3_out					:	OUT	STD_LOGIC_VECTOR(7 downto 0)
	);
END ENTITY;

ARCHITECTURE RTL OF REGISTERS IS

	COMPONENT REG8 IS -- inst reg8
	PORT (
		D					: IN  STD_LOGIC_VECTOR(7 downto 0);
		data_set			: IN	STD_LOGIC_VECTOR(7 downto 0);
		Reset1, Clock1 : IN  STD_LOGIC;
		set, Load 		: IN  STD_LOGIC;
		Q 					: OUT STD_LOGIC_VECTOR(7 downto 0)
	);
	END COMPONENT;

	SIGNAL L0, L1, L2, L3	: STD_LOGIC;
	SIGNAL Q0, Q1, Q2, Q3	: STD_LOGIC_VECTOR(7 downto 0);
	
BEGIN
	
	R0: REG8 -- reg0
	PORT MAP(
		D => Data,
		Reset1 => Reset,
		Clock1 => Clock,
		Load => L0, 
		Q => Q0,
		data_set => set_r0,
		set => set_reg
	);
	
	R1: REG8 -- reg1
	PORT MAP(
		D => Data,
		Reset1 => Reset,
		Clock1 => Clock,
		Load => L1, 
		Q => Q1,
		data_set => set_r1,
		set => set_reg
	);
	
	R2: REG8 -- reg2
	PORT MAP(
		D => Data,
		Reset1 => Reset,
		Clock1 => Clock,
		Load => L2, 
		Q => Q2,
		data_set => set_r2,
		set => set_reg
	);
	
	R3: REG8 -- reg3
	PORT MAP(
		D => Data,
		Reset1 => Reset,
		Clock1 => Clock,
		Load => L3, 
		Q => Q3,
		data_set => set_r3,
		set => set_reg
	);
	
	rsOut <=			Q0 WHEN rs = "00" -- read
				ELSE 	Q1 WHEN rs = "01"
				ELSE 	Q2 WHEN rs = "10"
				ELSE 	Q3 WHEN rs = "11";
				
	rtOut <=			Q0 WHEN rt = "00" -- read
				ELSE 	Q1 WHEN rt = "01"
				ELSE 	Q2 WHEN rt = "10"
				ELSE 	Q3 WHEN rt = "11";
	
	L0 <= regWrite WHEN rd = "00" ELSE '0'; -- regWrite
	L1 <= regWrite WHEN rd = "01" ELSE '0'; -- regWrite
	L2 <= regWrite WHEN rd = "10" ELSE '0'; -- regWrite
	L3 <= regWrite WHEN rd = "11" ELSE '0'; -- regWrite

	
	r0_out <= Q0; -- debug reg0
	r1_out <= Q1; -- debug reg0
	r2_out <= Q2; -- debug reg0
	r3_out <= Q3; -- debug reg0
	
END ARCHITECTURE;