#!/usr/bin/env python3

opcodes = {
	'add' : '000',
	'shift_right' : '001',
	'shift_left' : '010',
	'load' : '011',
	'xor' : '100',
	'store' : '101',
	'branch' : '110',
	'jump' : '111',
	}
	
registers = {
	"r0" : "00",
	'r1' : '01',
	'r2' : '10',
	'r3' : '11',
}
	
TOTAL_IMEM_SIZE = 2**10

with open('basic.asm') as ifile, open('inst_mem.hex', 'w') as imem:
	for lineno, line in enumerate(ifile):
		try:
			# Skip over blank lines, remove comments
			line = line.strip()
			line = line.split('//')[0].strip()
			if line == '':
				continue
			# Special-case this:
			if line[:4] == 'halt':
				machine_code = '111111111'
			else:
				# get the instruction name 
				op_name =  line.split()[0]
				machine_code = ''
				if op_name == 'jump':
					# split into op and jump location
					op, lo = line.split()
					op_bits = opcodes[op]
					imm_bits = "{0:b}".format(int(lo))
					machine_code = op_bits + imm_bits
				elif op_name in ['shift_left', 'shift_right']:
					# split into operation, reg souce and immediate to shift by
					op, rs, imm = line.split()
					op_bits = opcodes[op]
					reg_bits = registers[rs]
					imm_bits = "{0:b}".format(int(imm))
					machine_code = op_bits + reg_bits + imm_bits
					
				elif op_name in ['load', 'store']:
					# op + 2 args: split into op, rs, rt
					op, rs, rt = line.split()
					op_bits = opcodes[op]
					reg_s_bits = registers[rs]
					reg_t_bits = registers[rt]
					imm_bits = "{0:b}".format(int(imm))
					machine_code = op_bits + reg_s_bits + reg_t_bits + imm_bits
				else:
					# op + 3 args: split into op, rs1, rs2, rt
					op = opcodes[line[:3]]
					rt, rs1, rs2 = line[3:].split()
					reg_t_bits = registers[rt]
					reg_s1_bits = registers[rs1]
					reg_s2_bits = registers[rs2]
					machine_code = opcodes[op] + reg_t_bits+ reg_s1_bits + reg_s2_bits
					
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

