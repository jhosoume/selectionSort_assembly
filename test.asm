# Universidade de Brasília (UnB)
# Departamento de Ciência da Computação (CIC)
# Introdução aos Sistemas Computacionais
# Juliana Mayumi Hosoume 18/0048864
#
# Assembly language: MIPS
# O que este código faz: Selection Sort

# Declaração das variáveis
.data
	prompt_size: .asciiz "Qual o tamanho do vetor a ser ordenado? "
	prompt_num: .asciiz "Entre com os numeros para ordenacao: "
	print: .asciiz "O vetor eh: "
	space: .asciiz " "
	newline: .asciiz "\n"
	

# Indica que as instruções vem a seguir
.text 

# Função principal 
main: 
	# Print do prompt de tamanho
	la $a0, prompt_size
	li $v0, 4
	syscall
	
        # Load Size
        li $v0, 5
        syscall
	
	# Armazena o tamanho em $s1
	add $s1, $v0, $zero
	
	# Alocacao de espaco
	sll $a0, $v0, 2 # numero de bytes em $a0, multiplica por 4
        li  $v0, 9
        syscall 
        add $s0, $v0, $zero # guarda em s0 o vetor alocado
        
        # array => $s0
        # size  => $s1

setLoopRead:
	# Loop de leitura dos numeros do vetor
	# size counter => $s2
	# array[indx]  => $t0
	add $s2, $s1, $zero
	add $t0, $s0, $zero
	
	# Requisicao por numero
        la $a0, prompt_num
        li $v0, 4
        syscall
	
loopRead:
	ble $s2, $zero, setLoopPrint
        # Leitura do numero
        li $v0, 5
        syscall
        sw $v0, ($t0)
        addiu $t0, $t0, 4
        addi $s2, $s2, -1
        j loopRead
        
setLoopPrint:
	# Loop de leitura dos numeros do vetor
	# size counter => $s2
	# array[indx]  => $t0
	li $s2, 0
	add $t0, $s0, $zero
	
	la $a0, print
	li $v0, 4
	syscall
	
loopPrint:
        # Impressao de numero
        bge $s2, $s1, end
        lw $a0, ($t0)
        li $v0, 1
        syscall
        
        # Impressao de um espaco
        la $a0, space
        li $v0, 4
        syscall
        
        # Incremento do contador
        addiu $t0, $t0, 4
        addi $s2, $s2, 1
        j loopPrint
        
	# Encerrando o programa
end:
	li $v0, 10                                  # Indica no registrador $v0 o modo de encerrar execução do programa
	syscall		



# $a0 = array_pointer, $as1 = size
# getNums:
