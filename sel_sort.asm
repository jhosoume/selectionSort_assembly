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
	show_min: .asciiz "O minimo encontrado foi: "
	

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
	# array        => $t0
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
	# array[indx]  => $t0 (pointer)
	li $s2, 0
	add $t0, $s0, $zero
	
	la $a0, print
	li $v0, 4
	syscall
	
loopPrint:
        # Impressao de numero
        bge $s2, $s1, encontraMin
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
        
encontraMin:
	la $a0, newline
	li $v0, 4
	syscall
	
	la $a0, show_min
	li $v0, 4
	syscall
	
	add $a0, $s0, $zero
	li $a1, 0
	add $a2, $s1, $zero
	jal find_min
	
	add $a0, $v0, $zero
        li $v0, 1
        syscall
	
        
	# Encerrando o programa
end:
	li $v0, 10                                  # Indica no registrador $v0 o modo de encerrar execução do programa
	syscall		

# $a0 = a, $a1 = b, both are pointers
# $v0 = b, $v1 = a
# Com efeito colateral
swap:
	lw $t8, ($a0)
	lw $t9, ($a1)
	sw $t8, ($a1)
	sw $t9, ($a0)
	jr $ra
	
# $a0 = array, $a1 = start_indx, $a2 = size
find_min:
	# $t9 = indx, $t8 = array[indx] (value), $t7 = size, $t6 = array[indx] (pointer), $v0 = minimum value
	add $t9, $a1, $zero
	add $t7, $a2, $zero
	add $t6, $a0, $t9
	lw $t8, ($t6)
	add $v0, $t8, $zero
	
	# start at indx + 1
	addi $t9, $t9, 1
	addiu $t6, $t6, 4
	
loopMin:
        bge $t9, $t7, endLoopMin
        lw $t8, ($t6)
	bge $t8, $v0, skipEquals
	add $v0, $t8, $zero
skipEquals:
        # Incremento do contador
	addi $t9, $t9, 1
	addiu $t6, $t6, 4
        j loopMin
        
endLoopMin:
	jr $ra
