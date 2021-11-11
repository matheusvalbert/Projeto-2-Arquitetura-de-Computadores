LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY CONTROL IS
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
		jmp_out			: OUT STD_LOGIC
	);
END ENTITY;

ARCHITECTURE RTL OF CONTROL IS

	TYPE estado IS (initReg, fetch, decode, execR, writeR, beq, jmp);
	SIGNAL state, next_state : estado;

BEGIN

	PROCESS(state, inst)
	BEGIN
		CASE state IS
		
			WHEN initReg => -- estado inicial
				next_state <= fetch;
		
			WHEN fetch => -- estado "final"
				next_state <= decode;
				
			WHEN decode => -- decodificacao
				IF inst = "00" OR inst = "01" THEN -- instrucao tipoR (add e sub)
					next_state <= execR;
				ELSIF inst = "10" THEN -- instrucao tipo beq
					next_state <= beq;
				ELSIF inst = "11" THEN -- instrucao tipo jump
					next_state <= jmp;
				ELSE
					next_state <= fetch; -- else volta ao fetch
				END IF;
					
			WHEN execR =>
				next_state <= writeR; -- tipoR vai para estado escrita
				
			WHEN writeR =>
				next_state <= fetch; -- volta fetch
				
			WHEN beq =>
				next_state <= fetch; -- volta fetch
				
			WHEN jmp =>
				next_state <= fetch; -- volta fetch
				
			WHEN OTHERS =>
				next_state <= fetch; -- volta fetch
			
		END CASE;
	END PROCESS;

	PROCESS(Clock, Reset)
	BEGIN
		IF(Reset = '1') THEN --reset e estado inicial = initReg
			state <= initReg;
		ELSIF (rising_edge(Clock)) THEN -- borda de subida muda de estado
			state <= next_state;
		END IF;
	END PROCESS;
	
	set_reg <= '1' WHEN state = initReg ELSE '0'; -- inicializa os registradores estado inicial (nao sencivel a clock)
	
	next_pc <= '1' WHEN state = fetch OR (state = decode AND inst = "10") ELSE '0'; -- proximo pc, quando estado = fetch ou decode (caso a instrucao seja beq)
	
	load_reg_inst <= '1' WHEN state = fetch OR (state = decode AND inst = "10") ELSE '0'; -- escreve no reg. instrucao quando for fetch ou decode (caso a instrucao seja beq)
	
	set_a_b <= '1' WHEN state = decode ELSE '0'; -- set regA e regB, carrega registradores para a alu para ser executado no proximo ciclo
	
	set_alu_out <= '1' WHEN state = execR ELSE '0'; -- quarda o valor de saida da alu quando for instrucao tipoR
	
	regWrite <= '1' WHEN state = writeR ELSE '0'; -- escreve no banco de registradores, apenas quando for tipoR e estiver no estado de escrita
	
	op <= '1' WHEN state = execR AND inst = "00" ELSE '0'; -- caso seja instrucao tipoR e seja um add, a ula realiza uma soma, caso contrario subtracao
	
	set_addr <= '1' WHEN state = beq ELSE '0'; -- sinal de instrucao tipo beq
	
	jmp_out <= '1' WHEN state = jmp ELSE '0'; -- sinal de instrucao tipo jmp

END ARCHITECTURE;