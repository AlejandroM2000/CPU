MOV  r1  10					//  r1 = 00001010
SHIFTLEFT  r1  4				//  r1 = 10100000 (160)
LOAD  r1   r1   r4				//  r1 = data_mem[160+0]
SHIFTRIGHT  r1  3			//  r1 = 000_data_mem[160][7:3]
MOV  r2  8					//  r2 = 00001000
SHIFTLEFT  r2  4				//  r2 = 10000000 (128)
MOV  r4  0					// START PARTS A AND C
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTRIGHT  r3  3			//  r3 = 000_data_mem[ r2][7:3]
MOV  r4  12					
SHIFTLEFT  r4 1 		
MOV  r4  13
SHIFTLEFT  r4  1
MOV  r4  4
BOE  r3   r3   r4				// branch if found //NOTE: WILL END PROGRAM
MOV  r4  0
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  1
SHIFTRIGHT  r3  3			//  r3 = 000_data_mem[ r2][6:2]
MOV  r4  0					//  r4 = 
SHIFTLEFT  r4  0 				//  r4 = 
MOV  r4  0					//  r4 = 
BOE  r1   r3   r4				// branch if found
MOV  r4  0
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  2
SHIFTRIGHT  r3  3			//  r3 = 000_data_mem[ r2][5:1]
MOV  r4  0					//  r4 = 
SHIFTLEFT  r4  0				//  r4 = 
MOV  r4  0					//  r4 = 
BOE  r1   r3   r4      		// branch if found
MOV  r4  0
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  3
SHIFTRIGHT  r3  3			//  r3 = 000_data_mem[ r2][4:0]
MOV  r4  0					//  r4 = 
SHIFTLEFT  r4  0				//  r4 = 
BOE  r1   r3   r4				// branch if found
MOV  r4  9
SHIFTLEFT  r4  4			
MOV  r4  15					//  r4 = 10011111 (159)
MOV  r3  0
BOE  r4   r2   r3				// Skip checking across byte boundaries if reading data_mem[159]
MOV  r4  0
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  4
SHIFTRIGHT  r3  3			//  r3 = 000_data_mem[ r2][3:0]_0
LOAD  r4   r2  1
SHIFTRIGHT  r4  7			//  r4 = 0000000_data_mem[ r2+1][7]
ADD  r3   r3   r4				//  r3 = 000_data_mem[ r2][3:0]_data_mem[ r2+1][7]
MOV  r4  0
SHIFTLEFT  r4  0  
MOV  r4  0
BOE  r1   r3   r4				// branch if found
MOV  r4  0
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  5
SHIFTRIGHT  r3  3			//  r3 = 000_data_mem[ r2][2:0]_00
MOV  r4  1
LOAD  r4   r2   r4
SHIFTRIGHT  r4  6			//  r4 = 000000_data_mem[ r2+1][7:6]
ADD  r3   r3   r4				//  r3 = 000_data_mem[ r2][2:0]_data_mem[ r2+1][7:6]
MOV  r4  8
SHIFTLEFT  r4 3  
MOV  r4  0 
BOE  r1   r3   r4				// branch if found
MOV  r4  0
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  6
SHIFTRIGHT  r3  3    		//  r3 = 000_data_mem[ r2][1:0]_000
MOV  r4  1
LOAD  r4   r2   r4
SHIFTRIGHT  r4  5			//  r4 = 00000_data_mem[ r2+1][7:5]
ADD  r3   r3   r4				//  r3 = 000_data_mem[ r2][1:0]_data_mem[ r2+1][7:5]
MOV  r4  0
SHIFTLEFT  r4  0 
MOV  r4  0 
BOE  r1   r3   r4				// branch if found
MOV  r4  0
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  7
SHIFTRIGHT  r3  3			//  r3 = 000_data_mem[ r2][0]_0000
MOV  r4  1
LOAD  r4   r2   r4
SHIFTRIGHT  r4  4			//  r4 = 0000_data_mem[ r2+1][7:4]
ADD  r3   r3   r4				//  r3 = 000_data_mem[ r2][0]_data_mem[ r2+1][7:4]
MOV  r4  0 
SHIFTLEFT  r4 3  
MOV  r4  0
BOE  r1   r3   r4				// branch if found
MOV  r4  9					// increment data_mem idx
SHIFTLEFT  r4  4		
MOV  r4  15					//  r4 = 10011111 (159)
MOV  r3  0					//  r3 = 
SHIFTLEFT  r3  0 
SHIFTLEFT  r3  0 
MOV  r3  12					//  r3 = 
BOE  r4   r2   r3				// finish part a and c if  r2 == 159
MOV  r4  1
ADD  r2   r2   r4
MOV  r3  7
BOE  r3   r3   r3				// Return to line 7
MOV  r3  0					// Found 000_data_mem[ r2][7:3]
MOV  r4  0
BOE  r4   r4   r4				// Branch to increment data_mem[192] and data_mem[194]
MOV  r3 	0					// Found 000_data_mem[ r2][6:2]
MOV  r4  0
BOE  r4   r4   r4
MOV  r3 	0					// Found 000_data_mem[ r2][5:1]
MOV  r4  0
BOE  r4   r4   r4
MOV  r3 	0					// Found 000_data_mem[ r2][4:0]
MOV  r4  0
BOE  r4   r4   r4
MOV  r3 	0					// Found 000_data_mem[ r2][3:0]_data_mem[ r2+1][7]
MOV  r4  0
BOE  r4   r4   r4				// Branch to increment data_mem[194]
MOV  r3 	0					// Found 000_data_mem[ r2][2:0]_data_mem[ r2+1][7:6]
MOV  r4  0
BOE  r4   r4   r4
MOV  r3 	0					// Found 000_data_mem[ r2][1:0]_data_mem[ r2+1][7:5]
MOV  r4  0
BOE  r4   r4   r4
MOV  r3 	0					// Found 000_data_mem[ r2][0]_data_mem[ r2+1][7:4]
MOV  r4  0
BOE  r4   r4   r4
MOV  r4  12					//  r4 = 00001100 // Increment data_mem[192] 
SHIFTLEFT  r4  4				//  r4 = 11000000 (192)
MOV  r1  0
LOAD  r1   r4   r1				//  r1 = data_mem[192]
MOV  r4  1
ADD  r1   r4   r1				//  r1 = data_mem[192] + 1
MOV  r4  12					//  r4 = 00001100
SHIFTLEFT  r4  4				//  r4 = 11000000 (192)
MOV  r1  0
STORE  r1   r4   r1			// data_mem[192]++ 
MOV  r4  12					//  r4 = 00001100 // Increment data_mem[194]
SHIFTLEFT  r4  4				//  r4 = 11000000 (192)
MOV  r1  2
LOAD  r1   r4   r1				//  r1 = data_mem[194]
MOV  r4  1
ADD  r1   r4   r1				//  r1 = data_mem[194] + 1
MOV  r4  12					//  r4 = 00001100
SHIFTLEFT  r4  4				//  r4 = 11000000 (192)
MOV  r1  2
STORE  r1   r4   r1			// data_mem[194]++
MOV  r1  10					//  r1 = 00001010
SHIFTLEFT  r1  4				//  r1 = 10100000 (160)
MOV  r4  0
LOAD  r1   r1   r4				//  r1 = data_mem[160+0]
SHIFTRIGHT  r1  3			//  r1 = 000_data_mem[160][7:3]
BOE  r3   r3   r3				// Return to line at  r3	
MOV  r2  8					//  r2 = 00001000  PART B START
SHIFTLEFT  r2  4				//  r2 = 10000000 (128)
MOV  r4  0					// Check 1
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  3
SHIFTRIGHT  r3  3			//  r3 = 000_data_mem[ r2][4:0]
MOV  r4  12					//  r4 = 00001100
SHIFTLEFT  r4  4
MOV  r4  2					//  r4 = 11000010 (194)
BOE  r1   r3   r4				// branch if found
MOV  r4  0					// Check 2
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  5				//  r3 = 000_data_mem[ r2][5:1]
MOV  r4  12					//  r4 = 00001100
SHIFTLEFT  r4  4	
MOV  r4  2					//  r4 = 11000010 (194)
BOE  r1   r3   r4      		// branch if found	
MOV  r4  0					// Check 3
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTLEFT  r3  4				//  r3 = 000_data_mem[ r2][6:2]
MOV  r4  12					//  r4 = 00001100
SHIFTLEFT  r4  4
MOV  r4  2					//  r4 = 11000010 (194)
BOE  r1   r3   r4				// branch if found
MOV  r4  0					// Check 4
LOAD  r3   r2   r4				//  r3 = data_mem[ r2+0]
SHIFTRIGHT  r3  3			//  r3 = 000_data_mem[ r2][7:3]
MOV  r4  12					//  r4 = 00001100
SHIFTLEFT  r4  4
MOV  r4  2					//  r4 = 11000010 (194)
BOE  r1   r3   r4				// branch if found
MOV  r4  9					// increment data_mem idx
SHIFTLEFT  r4  4			
MOV  r4  15					//  r4 = 10011111 (159)
MOV  r3  0					//  r3 = 
SHIFTLEFT  r3  3 
SHIFTLEFT  r3  3 
MOV  r3  0					//  r3 = halt idx 
BOE  r4   r2   r3				// finish part b if  r2 == 159
MOV  r4  1
ADD  r2   r2   r4				//  r2++
MOV  r3  0
BOE  r3   r3   r3				// Return to line 11
MOV  r4  12					//  r4 = 00001100 // Increment data_mem[193]
SHIFTLEFT  r4  4				//  r4 = 11000000 (192)
MOV  r1  1
LOAD  r1   r4   r1				//  r1 = data_mem[193]
MOV  r4  1
ADD  r1   r4   r1				//  r1 = data_mem[193] + 1
MOV  r4  12					//  r4 = 00001100
SHIFTLEFT  r4  4				//  r4 = 11000000 (192)
MOV  r1  1
STORE  r1   r4   r1			// data_mem[193]++
MOV  r1  10					//  r1 = 00001010
SHIFTLEFT  r1  4				//  r1 = 10100000 (160)
MOV  r4  0
LOAD  r1   r1   r4				//  r1 = data_mem[160+0]
SHIFTRIGHT  r1  3			//  r1 = 000_data_mem[160][7:3]
BOE  r3   r3   r3				// TODO: Return to line at  r3
halt