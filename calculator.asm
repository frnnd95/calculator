.data
	#area para dados na memoria principal
	
var1: .asciiz "\n\nEscolha a opera��o a ser realizada. \n1)SOMA \n2)SUBTRA��O \n3)MULTIPLICA��O \n4)DIVIS�O \n5)RAIZ QUADRADA\n6)SAIR\n"
var2: .asciiz "Insira um valor: "
var3: .asciiz "O resultado �: "
erro_divisao_por_zero: .asciiz "N�o � poss�vel dividir por zero..."
erro_opcao_invalida: .asciiz "A op��o inserida � inv�lida... Digite um n�mero de 1 a 6."
result: .float 0.0  #float para guardar o resultado da raiz quadrada

.text

#Defini��o da macro soma
.macro soma
#solicitar primeiro input
la $a0, var2  #carrega var2 em a0
li $v0, 4  #imprimir a string
syscall  #chamada de sistema
li $v0, 5   #ler um inteiro
syscall  #chamada de sistema
move $t1, $v0  #move v0 para t1

#solicitar segundo input
la $a0, var2  #carrega var2 em a0
li $v0, 4  #imprimir a string
syscall  #chamada de sistema
li $v0, 5  #ler um inteiro
syscall  #chamada de sistema
move $t2, $v0  #move v0 para t2

#somar e imprimir o resultado
la $a0, var3  #carrega var3 em a0
li $v0, 4  #imprimir a string
syscall  #chamada de sistema

add $t0, $t1, $t2  #realiza a soma e armazena em t0
move $a0, $t0  #move o resultado de t0 para a0
li $v0, 1  #imprimir um inteiro
syscall  #chamada de sistema
j main  #pula para a label main, voltando ao menu principal
.end_macro

#Defini��o da macro subtra��o
.macro subtracao
#solicitar primeiro input
la $a0, var2  #carrega var2 em a0
li $v0, 4  #imprimir a string
syscall  #chamada de sistema
li $v0, 5  #ler um inteiro
syscall   #chamada de sistema
move $t1, $v0  #move v0 para t1

#solicitar segundo input
la $a0, var2  #carrega var2 em a0
li $v0, 4  #imprimir a string
syscall #chamada de sistema
li $v0, 5  #ler um inteiro
syscall  #chamada de sistema
move $t2, $v0  #move v0 para t2

#subtrair e imprimir o resultado
la $a0, var3  #carrega var3 em a0
li $v0, 4  #imprimir a string
syscall  #chamada de sistema

sub $t0, $t1, $t2  #realiza a subtra��o e armazena em t0
move $a0, $t0  #move t0 para a0
li $v0, 1  #imprimir um inteiro
syscall   #chamada de sistema
j main #pula para a label main, voltando ao menu principal
.end_macro

#Defini��o da macro multiplica��o
.macro multiplicacao
#solicitar primeiro input
la $a0, var2  #carrega var2 em a0
li $v0, 4  #imprimir a string
syscall  #chamada de sistema
li $v0, 5  #ler um inteiro
syscall   #chamada de sistema
move $t1, $v0  #move v0 para t1

#solicitar segundo input
la $a0, var2  #carrega var2 em a0
li $v0, 4   #imprimir a string
syscall  #chamada de sistema
li $v0, 5  #ler um inteiro
syscall  #chamada de sistema
move $t2, $v0  #move v0 para t2

#multiplicar e imprimir o resultado
la $a0, var3  #carrega var3 em a0
li $v0, 4   #imprimir a string
syscall  #chamada de sistema

mul $t0, $t1, $t2  #realiza a multiplica��o e armazena em t0
move $a0, $t0  #move t0 para a0
li $v0, 1  #imprimir um inteiro
syscall  #chamada de sistema
j main #pula para a label main, voltando ao menu principal
.end_macro

#Defini��o da macro divis�o
.macro divisao
#solicitar primeiro input
la $a0, var2  #carrega var2 em a0
li $v0, 4   #imprimir a string
syscall  #chamada de sistema
li $v0, 5  #ler um inteiro
syscall  #chamada de sistema
move $t1, $v0  #move v0 para t1

#solicitar segundo input
la $a0, var2  #carrega var2 em a0
li $v0, 4   #imprimir a string
syscall  #chamada de sistema
li $v0, 5  #ler um inteiro
syscall  #chamada de sistema
move $t2, $v0  #move v0 para t2

#verificar se o segundo operando � 0. 
beq $t2, 0, divisao_por_zero #se o valor em t2, que � o divisor, for igual a 0, pular para label divisao_por_zero

#dividir e imprimir resultado
la $a0, var3   #carrega var3 em a0
li $v0, 4  #imprimir a string
syscall  #chamada de sistema

div $t0, $t1, $t2 #o resultado da divis�o � salvo em $t0
move $a0, $t0  #move t0 para a0
li $v0, 1   #imprimir um inteiro
syscall  #chamada de sistema
j main #pula para a label main, voltando ao menu principal
.end_macro

#Defini��o da macro de raiz quadrada
.macro raizq
#solicitar input(float)
la $a0, var2  #carrega var2 em a0
li $v0, 4    #imprimir a string
syscall  #chamada de sistema
li $v0, 6  #ler um float
syscall  #chamada de sistema
mov.s $f12, $f0  #move f0 para f12

#calcular a raiz quadrada usando a fun��o sqrt
sqrt.s $f12, $f12 #usando a fun��o da biblioteca padr�o MIPS, calcula a raiz quadrada de $f12 e a guarda no pr�prio $f12
swc1 $f12, result #salva o valor de $f12 na vari�vel result

#carregar o resultado e imprimir
la $a0, var3  #carrega var3 em a0
li $v0, 4   #imprimir a string que deve aparecer antes do resultado
syscall  #chamada de sistema 

lwc1 $f12, result #carrega o valor da vari�vel result em $f12
li $v0, 2 #coloca valor 2 em $v0, para impress�o de float
syscall  #chamada de sistema, imprime a float
j main  #pula para a label main, voltando ao menu principal
.end_macro

.globl main

#label main. Esta parte apresent o menu principal e solicita uma opcao do usu�rio
main: 
		
#impress�o de string
la $a0, var1  #carrega var1 em a0
li $v0, 4  #carrega valor 4 em $v0 (imprimir a string)
syscall  #chamada de sistema para imprimir a string mostrando o menu para escolha de opera��o
#lendo o inteiro e movendo para o registrador t3
li $v0, 5  #coloca o valor 5 em v0, para input de inteiro
syscall  #chamada de sistema para input de inteiro, para ler a op��o do usu�rio
move $t3, $v0  #move a opcao inserida de v0 para t3


#condicionais para validar o input, e prosseguir para a opera��o escolhida.
blt $t3, 1, opcao_invalida # salta para a label opcao_invalida se o numero inserido for menor que 1 
bgt $t3, 6, opcao_invalida # salta para a label opcao_invalida se o numero inserido for maior que 6 
beq $t3, 1, somar #se o valor em t3 for igual a 1, pular para a label de soma.
beq $t3, 2, subtrair #se o valor em t3 for igual a 2, pular para a label de subtra��o.
beq $t3, 3, multplicar #se o valor em t3 for igual a 3, pular para a label de multiplica��o.
beq $t3, 4, dividir #se o valor em t3 for igual a 4, pular para a label de divis�o.
beq $t3, 5, raiz #se o valor em t3 for igual a 5, pular para a label de raiz quadrada.
beq $t3, 6, sair #se o valor em t3 for igual a 6, pular para a label de sair para encerrar o programa.

somar: #label para adi��o 
soma #chamar a macro de soma

subtrair: #label para subtra��o
subtracao #chamar a macro de subtracao

multplicar: #label para multiplica��o
multiplicacao #chamar a macro de multiplica��o

dividir: #label para divis�o
divisao #chamar a macro de divis�o

raiz: #label de calculo da raiz quadrada
raizq #chamar a macro de raiz quadrada



divisao_por_zero: #label de divisao por zero
li $v0, 4   #carrega valor 4 em v0, para imprimir a string
la $a0, erro_divisao_por_zero #carrega o endere�o da string desejada para impress�o, a vari�vel indicada, que tem mensagem de erro
syscall   #chamada de sistema para entao imprimir
j sair #pula para a label de sa�da

opcao_invalida:
li $v0, 4   #carrega valor 4 em v0, para imprimir a string
la $a0, erro_opcao_invalida  #carrega o endere�o da string desejada para impress�o, a vari�vel indicada, que tem mensagem de erro
syscall   #chamada de sistema para entao imprimir
j main #pula para a label main, reiniciando o programa

sair: #label de sa�da.

li $v0, 10 #carrega o valor 10 em v0, para sair do programa na chamada de sistema
syscall  #chamada de sistema
