MOV r2 7
SHIFTLEFT r2 4
MOV r2 15
MOV r3 1
SHIFTLEFT r3 4
MOV r3 15
MOV r1 0 
MOV r2 0 //loop back to this line
SHIFTLEFT r2 4
MOV r4 1
ADD r2 r1 r4  //r2 = odd number (13579...)
LOAD r3 r1 r2 
LOAD r4 r1 0   //(r4 = 01010101)
//p8 parity bit
SHIFTLEFT r3 5
SHIFTRIGHT r4 3 
ADD r3 r4 r3 //b11:b5 are the top of the word
SHIFTRIGHT r3 1 //to get rid of that extra bit at the bottom of the word
XORR r4 r3 0  //p8 parity bit and teh MSWo
SHIFTLEFT r4 7
SHIFTRIGHT r4 7
SHIFTLEFT r3 1
ADD r3 r4 r3
MOV r2 1
SHIFTLEFT r2 4
MOV r2 15
STORE r3 r1 r2 //STOREs it in the corresponding location
//r3 = b11 b10 b9 b8 b7 b6 b5 p8
//r4 = 0 0 0 b8 b7 b6 b5 b4
SHIFTRIGHT r3 4 //r3 = 0 0 0 0 b11 b10 b9 b8 start of p4
MOV r4 0
SHIFTLEFT r4 4
MOV r4 1
ADD r2 r1 r4
LOAD r4 r1 0  //r4 = b8 b7 b6 b5 b4 b3 b2 b1 LSWi
SHIFTLEFT r4 4 //r4 = b4 b3 b2 b1 0 0 0 0
SHIFTRIGHT r4 5 //r4 = 0 0 0 0 0 b4 b3 b2 
SHIFTLEFT r4 4 // r4 = 0 b4 b3 b2 0  0 0 0
ADD r3 r4 r3 // r3 = 0 b4 b3 b2 b11 b10 b9 b8
XORR r3 r3 3 // r3 = 0 b4 b3 b2 p4 b10 b9 b8
SHIFTLEFT r3 1 //r3 =  b4 b3 b2 p4 b10 b9 b8 0 
SHIFTRIGHT r3 4 //r3 = 0 0 0 0 b4 b3 b2 p4 
SHIFTLEFT r3 4 //r3 =  b4 b3 b2 p4 0 0 0 0
MOV r2 1
SHIFTLEFT r2 4
MOV r2 14 //r2 = 0001_1110 = 30
STORE r3 r1 r2 //stores half of the LSWo into memory base_Address + 30
MOV r4 0
SHIFTLEFT r4 4
MOV r4 1
ADD r2 r1 r4
LOAD r4 r2 0 //loads the MSWi 
SHIFTRIGHT r4 1
SHIFTLEFT r4 6 //r4 = b11 b10 0 0 0 0 0 0
LOAD r3 r1 0 // LSWi gets laoded form memory
SHIFTLEFT r3 1
SHIFTRIGHT r3 6
SHIFTLEFT r3 4 // r3 = 0 0 b7 b6 0 0 0 0 
ADD r4 r3 r4 // r4 = b11 b10 b7 b6 0 0 0 0
LOAD r3 r1 0 // LSWi gets laoded form memory r3 = b8 b7 b6 b5 b4 b3 b2 b1
SHIFTLEFT r3 4 // r3 = b4 b3 b2 b1 0 0 0 0
SHIFTRIGHT r3 6 // r3 = 0 0 0 0 0 0 b4 b3
SHIFTLEFT r3 2 // r3 = 0 0 0 0 b4 b3 0 0 
ADD r4 r3 r4 // r4 = b11 b10 b7 b6 b4 b3 0 0
LOAD r3 r1 0 // LSWi gets laoded form memory
SHIFTLEFT r3 7 // r3 = b1 0 0 0 0 0 0 0
SHIFTRIGHT r3 6 // r3 0 0 0 0 0 0 b1 0
ADD r4 r3 r4 // r4 = b11 b10 b7 b6 b4 b3 b1 0
XORR r4 r4 0 // r4 = b11 b10 b7 b6 b4 b3 b1 p2
SHIFTLEFT r4 6 // r4 = b1 p2 0 0 0 0 0 0
SHIFTRIGHT r4 4 // r4 = 0 0 0 0 b1 p2 0 0
MOV r2 1
SHIFTLEFT r2 4
MOV r2 14 // r2 = 30
LOAD r3 r1 r2 // r3 = b4 b3 b2 p4 0 0 0 0
ADD r3 r4 r3 // r3 = b4 b3 b2 p4 b1 p2 0 0 
STORE r3 r1 r2 //stores the LSWo into the corresponding part of memory
MOV r4 0
SHIFTLEFT r4 4
MOV r4 1
ADD r2 r1 r4
LOAD r4 r2 0 //want to load MSWi
SHIFTRIGHT r4 2 // r4 = 0 0 0 0 0 0 0 b11
LOAD r3 r2 0 // r3 = 0 0 0 0 0 b11 b10 b9
SHIFTLEFT r3 7 // r3 = b9 0 0 0 0 0 0 0
SHIFTRIGHT r4 6 //r3 = 0 0 0 0 0 0 b9 0
ADD r4 r3 r4 // r4 = 0 0 0 0 0 0 b9 b11
LOAD r3 r1 0 //loads the LSWi from memory
SHIFTRIGHT r3 6 // r3 = 0 0 0 0 0 0 0 b7
SHIFTLEFT r3 7 // r3 = b7 0 0 0 0 0  0 0
SHIFTRIGHT r3 5 // r3 = 0 0 0 0 0 b7 0 0
ADD r4 r3 r4 //r4 = 0 0 0 0 0 b7 b9 b11
LOAD r3 r1 0 //loads the LSWi from memory
SHIFTRIGHT r3 4 // r3 = 0 0 0 0 x x x b5
SHIFTLEFT r3 7 // r3 = b5 0 0 0 0 0  0 0
SHIFTRIGHT r3 4// r3 = 0 0 0 0 b5 0 0 0
ADD r4 r3 r4 //r4 = 0 0 0 0 b5 b7 b9 b11
LOAD r3 r1 0 //loads the LSWi from memory
SHIFTRIGHT r3 3 // r3 = 0 0 0 x x x x b4
SHIFTLEFT r3 7 // r3 = b4 0 0 0 0 0  0 0
SHIFTRIGHT r3 3// r3 = 0 0 0 b4 0 0 0 0
ADD r4 r3 r4 //r4 = 0 0 0 b4 b5 b7 b9 b11
LOAD r3 r1 0 //loads the LSWi from memory
SHIFTRIGHT r3 1 // r3 = 0 x x x x x x b2
SHIFTLEFT r3 7 // r3 = b2 0 0 0 0 0  0 0
SHIFTRIGHT r3 2// r3 = 0 0 b2 0 0 0 0 0
ADD r4 r3 r4 //r4 = 0 0 b2 b4 b5 b7 b9 b11
LOAD r3 r1 0 //loads the LSWi from memory
SHIFTLEFT r3 7 // r3 = b1 0 0 0 0 0  0 0
SHIFTRIGHT r3 1// r3 = 0 b1 0 0 0 0 0 0
ADD r4 r3 r4 //r4 = 0 b1 b2 b4 b5 b7 b9 b11
MOV r3 0
SHIFTLEFT r3 4
MOV r3 7
XORR r4 r4 r3 //r4 = p1 b1 b2 b4 b5 b7 b9 b11
SHIFTRIGHT r4 7
SHIFTLEFT r4 1 // r4 = 0 0 0 0 0 0 p1 0
MOV r2 1
SHIFTLEFT r2 4
MOV r2 14 // r2 = 30
LOAD r3 r1 r2 //Loads the LSWo form memory
ADD r4 r4 r3 //r4 = b4 b3 b2 p4 b1 p2 p1 0
STORE r4 r1 r2 //stores the LSWo into memory
XORR r4 r4 0 //r4 = b4 b3 b2 p4 b1 p2 p1 parity_bit_16_intermediate
SHIFTLEFT r4 7 //r4 = parity_bit_16_intermediate 0 0 0 0 0 0 0 
MOV r2 1
SHIFTLEFT r2 4
MOV r2 15 // r2 = 31
LOAD r3 r1 r2 //loads in the MSWo from memory
XORR r4 r3 1 // r4 = 16_1 0 0 0 0 0 16_2 0
XORR r4 r4 0 // r4 = 16_1 0 0 0 0 0 16_2 p16
SHIFTLEFT r4 7
SHIFTRIGHT r4 7
MOV r2 1
SHIFTLEFT r2 4 //r4 = 0 0 0 0 0 0 0 p_16
MOV r2 14
LOAD r3 r1 r2 //Loads the LSWo form memory
ADD r3 r4 r3 //r3 = b4 b3 b2 p4 b2 p2 b1 p16
STORE r3 r1 r2 //stores the complete LSWo into memory
MOV r3 2
SHIFTLEFT r3 4
MOV r3 0 // r3 == 32
MOV r4 0
SHIFTLEFT r4 4
MOV r4 2
ADD r1 r1 r4
MOV r2 9
SHIFTLEFT r2 4
MOV r2 11
BOE r1 r3 r2 //r1 = even number (02468...) //exit condition
MOV r2 0
SHIFTLEFT r2 4
MOV r2 8 //branch condition
BOE r1 r1 r2
halt
