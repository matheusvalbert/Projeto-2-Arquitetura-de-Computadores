# Projeto 2: Arquitetura de Computadores

O projeto foi desenvolvido utilizando VHDL (matéria quarto semestre de engenharia de computação).

# Especificações

Criar uma CPU multiciclo que realiza as seguintes instruções e seus opcodes:
- ADD:  00
- SUB:  01
- BEQ:  10
- JUMP: 11

### Formato das instruções

<p align="center">
  <img width="60%" src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/instrucoes.png" />
</p>

- Tipo R:

<p align="center">
  <img width="60%" src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/tipoR.png" />
</p>

- Tipo Condicional:

<p align="center">
  <img width="60%" src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/tipoCOND.png" />
</p>

- Tipo  J:

<p align="center">
  <img width="60%" src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/tipoJ.png" />
</p>

### Máquina de estados

O estado initReg é utilizado para inicializar os registradores, pois não existe uma instrução que permite adicionar um valor ao registrador.

<p align="center">
  <img src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/maquina_de_estado.png" />
</p>

### CPU

<p align="center">
  <img src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/cpu.png" />
</p>

### Tabelas de sinais

- Inicializar registrador:

<p align="center">
  <img width="60%" src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/initReg.png" />
</p>

- Tipo R:

<p align="center">
  <img width="60%" src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/tipoR_sig.png" />
</p>

- Tipo BEQ:

<p align="center">
  <img width="60%" src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/tipoBEQ_sig.png" />
</p>

- Tipo JMP:

<p align="center">
  <img width="60%" src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/tipoJMP_sig.png" />
</p>

# Testes realizados

Os valores iniciais dos registradores podem ser encontrados nas linhas 152 a 155 no arquivo 'cpu.vhd':
- R0: 00000011
- R1: 00000011
- R2: 00110000
- R3: 11000000

Programa teste:
```
(00) BEQ R2, R3, 00 (Não realiza o Jump)
(01) POS 0001 0100 (20)
(02) ADD R3, R3, R2 (R3 = 1111 0000) (Realiza a soma)
(03) BEQ R0, R1, 00 (Realiza o Jump)
(04) POS 0001 0100 (20)
...
(20) SUB R2, R2, R1 (R2 = 0010 1101)
(21) JMP 01 1001 (25)
(22) ADD R3, R3, R2 (Não realiza o Add) (R3 = 0001 1101)
...
(25) SUB R3, R2, R1 (R3 = 0010 1010)
...
```

# Resultados

<p align="center">
  <img src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/initRegs_BEQ_not_taken.png" />
</p>

<p align="center">
  <img src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/ADD.png" />
</p>

<p align="center">
  <img src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/BEQ_taken.png" />
</p>

<p align="center">
  <img src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/SUB.png" />
</p>

<p align="center">
  <img src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/JMP.png" />
</p>

<p align="center">
  <img src="https://github.com/matheusvalbert/Projeto-2-Arquitetura-de-Computadores/blob/main/SUB_apos_JMP.png" />
</p>
