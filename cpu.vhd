LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY CPU IS
	PORT (
		Clk			 : 	IN 	STD_LOGIC; -- clk
		reset_s		 :		IN 	STD_LOGIC;
		pc_out		 :  	OUT	STD_LOGIC_VECTOR(7 downto 0); -- debug pc
		reg_inst_out : 	OUT	STD_LOGIC_VECTOR(7 downto 0); -- debug reg. inst.
		reg_beq_out	 :		OUT	STD_LOGIC_VECTOR(7 downto 0);
		reg0			 : 	OUT	STD_LOGIC_VECTOR(7 downto 0); -- debug reg0
		reg1			 : 	OUT	STD_LOGIC_VECTOR(7 downto 0); -- debug reg1
		reg2			 : 	OUT	STD_LOGIC_VECTOR(7 downto 0); -- debug reg2
		reg3			 : 	OUT	STD_LOGIC_VECTOR(7 downto 0)  -- debug reg3
	);
END ENTITY;

ARCHITECTURE RTL OF CPU IS

	SIGNAL alu_op			: STD_LOGIC := '0';
	
	SIGNAL set_regs		: STD_LOGIC;
	SIGNAL write_regs		: STD_LOGIC;
	SIGNAL load_a_b		: STD_LOGIC;
	SIGNAL load_alu_out	: STD_LOGIC;
	SIGNAL zero				: STD_LOGIC;
	SIGNAL write_inst		: STD_LOGIC;
	SIGNAL load_addr		: STD_LOGIC;
	SIGNAL load_pc			: STD_LOGIC;
	SIGNAL beq				: STD_LOGIC;
	SIGNAL jmp				: STD_LOGIC;
	SIGNAL make_jmp		: STD_LOGIC;
	SIGNAL load_beq		: STD_LOGIC;
	
	SIGNAL A_out, B_out			: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL result					: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL write_data				: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL data_instruction 	: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL adress_instruction 	: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL instruction_exec 	: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL A_in, B_in  			: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL jmp_inst				: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL beq_data				: STD_LOGIC_VECTOR(7 downto 0);
	
	COMPONENT CONTROL -- unidade de controle
		PORT (
			Reset      		: IN  STD_LOGIC;
			Clock      		: IN  STD_LOGIC;
			inst				: IN	STD_LOGIC_VECTOR(1 downto 0);
			set_reg			: OUT	STD_LOGIC;
			regWrite			: OUT	STD_LOGIC;
			set_a_b			: OUT	STD_LOGIC;
			set_alu_out		: OUT	STD_LOGIC;
			op					: OUT	STD_LOGIC;
			load_reg_inst	: OUT	STD_LOGIC;
			set_addr			: OUT	STD_LOGIC;
			next_pc			: OUT	STD_LOGIC;
			jmp_out			: OUT STD_LOGIC;
			beq_load			: OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT PC
		PORT(
			NextInst	 : IN  STD_LOGIC;
			LoadAddr	 : IN	 STD_LOGIC;
			AddrIn 	 : IN	 STD_LOGIC_VECTOR(7 downto 0);
			Clock     : IN  STD_LOGIC;
			AddrOut	 : OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;

	COMPONENT REGISTERS -- banco de registradores
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
	END COMPONENT;

	COMPONENT ALU -- ula
		PORT (        
			op		: IN 	STD_LOGIC;
			A		: IN 	STD_LOGIC_VECTOR(7 downto 0);
			B		: IN 	STD_LOGIC_VECTOR(7 downto 0);
			res	: OUT STD_LOGIC_VECTOR(7 downto 0);
			z		: OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT ROM -- memoria principal
		PORT (
			address 	: 	IN 	STD_LOGIC_VECTOR(7 downto 0);
			data 		: 	OUT 	STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;

	COMPONENT REG8 -- regA, regB, AluOut, reg. Inst
		PORT (
			D					: IN  STD_LOGIC_VECTOR(7 downto 0);
			data_set			: IN	STD_LOGIC_VECTOR(7 downto 0);
			Reset1, Clock1 : IN  STD_LOGIC;
			set, Load 		: IN  STD_LOGIC;
			Q 					: OUT STD_LOGIC_VECTOR(7 downto 0)
		);
	END COMPONENT;

BEGIN

	CONTROL_0: CONTROL -- u.c.
	PORT MAP(
		Reset => reset_s,
		Clock => Clk,
		inst => instruction_exec(7 downto 6),
		set_reg => set_regs,
		regWrite => write_regs,
		set_a_b => load_a_b,
		set_alu_out => load_alu_out,
		op => alu_op,
		load_reg_inst => write_inst,
		set_addr => load_addr,
		next_pc => load_pc,
		jmp_out => jmp,
		beq_load => load_beq
	);

	PC_0: PC -- pc
	PORT MAP(
		NextInst => load_pc,
		LoadAddr => make_jmp,
		AddrIn => jmp_inst,
		Clock => Clk,
		AddrOut => adress_instruction
	);

	REGISTERS_0: REGISTERS -- banco reg.
	PORT MAP(
		rs => instruction_exec(5 downto 4),
		rt => instruction_exec(3 downto 2),
		rd => instruction_exec(1 downto 0),
		Reset => reset_s,
		Clock => Clk,
		regWrite => write_regs,
		Data => write_data,
		set_reg => set_regs,
		set_r0 => "00000011", -- valor inicial R0 = 3
		set_r1 => "00000011", -- valor inicial R1 = 3
		set_r2 => "00110000", -- valor inicial R2 = 48
		set_r3 => "11000000", -- valor inicial R3 = 192
		rsOut => A_in,
		rtOut => B_in,
		r0_out => reg0,
		r1_out => reg1,
		r2_out => reg2,
		r3_out => reg3
	);

	ALU_0: ALU -- ula
	PORT MAP(
		op => alu_op,
		A => A_out,
		B => B_out,
		res => result,
		z => zero
	);

	ROM_0: ROM -- memoria principal
	PORT MAP(
		address => adress_instruction,
		data => data_instruction
	);

	REG_INST: REG8 -- reg. instrucao
	PORT MAP(
		D => data_instruction,
		data_set => "ZZZZZZZZ",
		Reset1 => reset_s,
		Clock1 => Clk,
		set => '0',
		Load => write_inst,
		Q => instruction_exec
	);

	REG_A: REG8 -- regA
	PORT MAP(
		D => A_in,
		data_set => "ZZZZZZZZ",
		Reset1 => reset_s,
		Clock1 => Clk,
		set => '0',
		Load => load_a_b,
		Q => A_out
	);

	REG_B: REG8 -- regB
	PORT MAP(
		D => B_in,
		data_set => "ZZZZZZZZ",
		Reset1 => reset_s,
		Clock1 => Clk,
		set => '0',
		Load => load_a_b,
		Q => B_out
	);

	REG_ALU_OUT: REG8 -- AluOut
	PORT MAP(
		D => result,
		data_set => "ZZZZZZZZ",
		Reset1 => reset_s,
		Clock1 => Clk,
		set => '0',
		Load => load_alu_out,
		Q => write_data
	);
	
	REG_BEQ: REG8 -- reg BEQ (Auxiliar BEQ)
	PORT MAP(
		D => data_instruction,
		data_set => "ZZZZZZZZ",
		Reset1 => reset_s,
		Clock1 => Clk,
		set => '0',
		Load => load_beq,
		Q => beq_data
	);

	beq <= load_addr AND zero; -- beq condicional
	
	make_jmp <= beq OR jmp; -- escrita pc = regInst
	
	jmp_inst <= beq_data 																			WHEN beq = '1' -- caso regInst = beq
			ELSE	adress_instruction(7 downto 6) & instruction_exec (5 downto 0)		WHEN jmp = '1' -- caso regInst = jmp
			ELSE  "ZZZZZZZZ";
			
	pc_out <= adress_instruction; --debug pc
	reg_inst_out <= instruction_exec; -- debug reg. instrucao
	reg_beq_out <= beq_data; -- debug reg_beq
	
END ARCHITECTURE;