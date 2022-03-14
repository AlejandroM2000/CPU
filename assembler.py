#!/usr/bin/env python3

opcodes = {
	'ADD' : '000',
	'SHIFTRIGHT' : '001',
	'SHIFTLEFT' : '010',
	'LOAD' : '011',
	'XOR' : '100',
	'STORE' : '111',
	'BRANCH' : '110',
	'MOV' : '101',
	}
	
registers = {
	"r1" : "00",
	'r2' : '01',
	'r3' : '10',
	'r4' : '11',
}
	

TOTAL_IMEM_SIZE = 2**10

with open('basic.asm') as ifile, open('inst_mem.hex', 'w') as imem:
	for lineno, line in enumerate(ifile):
		try:
			# Skip over blank lines, remove comments
			line = line.strip()
			line = line.split('//')[0].strip()
			print(line + "\n")
			if line == '':
				continue
			# Special-case this:
			if line[:4] == 'halt':
				machine_code = '111111111'
			else:
				# get the instruction name 
				op_name =  line.split()[0]
				print(op_name + "\n")
				machine_code = ''
				if op_name == 'MOV':
					# split into op and jump location
					op, reg_1, imm = line.split()
					op_bits = opcodes[op]
					reg_bits = registers[reg_1]
					imm_bits = "{0:04b}".format(int(imm))
					machine_code = op_bits + reg_1 + imm_bits
				elif op_name in ['SHIFTLEFT', 'SHIFTRIGHT']:
					# split into operation, reg souce and immediate to shift by
					op, rs, imm = line.split()
					op_bits = opcodes[op]
					reg_bits = registers[rs]
					imm_bits = "{0:04b}".format(int(imm))
					machine_code = op_bits + reg_bits + imm_bits		
				elif op_name in ['LOAD', 'STORE']:
					# op + 2 args: split into op, rs, imm
					op, rs, rd, op_1 = line.split()
					op_bits = opcodes[op]
					reg_s_bits = registers[rs]
					rd_bits = registers[rd]
					op_1_bits = ""
					if len(op_1) > 1 :
						op_1_bits = registers[op_1]
					else: 
						op_1_bits = "{0:2b}".format(int(imm))
					machine_code = op_bits + reg_s_bits + rd_bits + imm_bits
				else:
					# op + 3 args: split into op, rs1, rs2, rt
					op, rt, rs1, operand = line.split()
					operand_bits = ''
					if len(operand) == 1:
						operand_bits = "{0:2b}".format(int(imm))
					else:
						operand_bits = registers[operand]
					reg_t_bits = registers[rt]
					reg_s1_bits = registers[rs1]
					machine_code = op + reg_t_bits+ reg_s1_bits + operand_bits
					
			# Write the imem entry
			imem.write(machine_code + '\n')
			TOTAL_IMEM_SIZE -= 1

		except:
			print("Error Parsing Line ", lineno)
			print(">>>{}<<<".format(line))
			print()
			raise

	# This is a neat trick to catch programming errors:
	# Fill the rest of instruction memory with illegal instructions.
	#
	while TOTAL_IMEM_SIZE:
		imem.write('xxxxxxxxx\n')
		TOTAL_IMEM_SIZE -= 1

