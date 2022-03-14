    BOE r1, 31, exit //r1 = even number (0,2,4,6,8...)
    MOV r2, 0
    LOAD r3, r1, r2 
    ADD r2, r1, 1  //r2 = odd number (1,3,5,7,9...)
    LOAD r4, r2, 0   //(r4 = 01010101)
    //I think this part should work above just fine becasuse here we are just grabbing the input from data_mem[0:29], in this case we don't need the offsets at this point because the registers can
    //just LOAD in directly from the mmeory because the regsiters can hold up to 8 bits
    MOV r2, 7 //this stores the mask of 0111 fro thenext instruction to work properly
    AND r3, r3, r2 //masks the bits in r3 to get the necessary btis only
    MOV r2, 5
    SHIFTLEFT r3, r3, r2 // 5 = 101
    SHIFTRIGHT r4, r4, 3
    MOV r2, 0001
    SHIFTLEFT r2, 4 
    MOV r2, 1110
    AND r4, r4, r2
    ADD r3, r3, r4
    XORR r3, 0, r3 //gives the p8 bit AND the MSWo in the same line 31 = 0001_1111
    MOV r2, 0001
    SHIFTLEFT r2, 4
    MOV r2, 1111
    STORE r3, r1, r2 //STOREs it in the corresponding location

    SHIFTLEFT r2, 4 // bit mask = 1111_0000
    AND r3, r3, r2 // this gives us bits b11 b10 b9 b8 in the top of the register
    MOV r2, 0
    LOAD r4, r1, r2 //loads back in the LSWi
    MOV r2, 15
    AND r4, r4, r2 //gives the b4 b3 b2 bits using the mask
    SHIFTLEFT r4, 4
    SHIFTRIGHT r3, 4
    ADD r3, r3, r4 //b4 b3 b2 b11 b10 b9 b8 _
    XORR r4, 3, r3 //b4 b3 b2 p4 x x x x  30 = 0001_1110
    MOV r2, 0001
    SHIFTLEFT r2, 4
    MOV r2, 1110
    STORE r4, r2 //STOREs b4 b3 b2 p4 x x x x into memory, this is half of the LSW

    MOV r2, 0001
    SHIFTLEFT r2, 4
    MOV r2, 1111 //this is the mmeory address needed to load MSWo from memory
    LOAD r3, r2,0 //LOADs complete MSWo from memory
    AND r3, r3, 11001100 //gets only the b11 b10 b7 b4 bits needed for the parity
    LOAD r4, r1, 0 //LOADs LSWi from memory
    XORR r3, 0 ,r3 //intermediate xor for all the first 4 bits needed
    MOV r2, 0000
    SHIFTLEFT r2, 4
    MOV r2, 0001
    AND r3, r3, r2 //only keeping the intermediate bit with this mask
    MOV r2, 1101
    AND r4, r4, r2
    SHIFTLEFT r4, 4
    ADD r3, r3, r4 //the intermediate xor bit AND the other needed bits are now in the same register
    XORR r3, 0, r3 //now we have the p2 bit 
    MOV r2, 0001
    AND r3, r3, r2//only keeping the xor bit
    SHIFTLEFT r3, r3, 2 
    MOV r2, 0001
    SHIFTLEFT r2, 4
    MOV r2, 1110 //trying to load LWSo from memory
    LOAD r4, r1, r2 //loads the LSWo from memory with offset 30 and the index depending on the loop
    MOV r2, 1111
    SHIFTLEFT r2, 4
    MOV r2, 0000 // bit mask of 1111_0000 is created to keep the top half of the register
    AND r4, r4, r2
    ADD r4, r3, r4 //b4 b3 b2 p4 _ p2 _ _ is now in a register
    LOAD r3, r1, 0 //LOADs the LSWi into a register
    MOV r2, 0000
    SHIFTLEFT r2, 4
    MOV r2, 0001
    AND r3, r3, r2//bit mask to keep the bit bit
    SHIFTLEFT r3, 4
    ADD r4, r3, r4 //b4 b3 b2 p4 b1 p2 _ _ is now in a register
    MOV r2, 0001
    SHIFTLEFT r2, 4
    MOV r2, 1110
    STORE r4, r1, r2 //stores b4 b3 b2 p4 b1 p2 _ _ into memory

    ADD r2, r2, 01
    LOAD r3, r1, r2 //LOADs the MSWo from memory into reg 3
    MOV r2, 1010
    SHIFTLEFT r2, 4
    MOV r2, 1010
    AND r3, r3, r2 //bit mask to get the b11 b9 b7 AND b5 bits
    XORR r3, 0, r3
    MOV r2, 0000
    SHIFTLEFT r2, 4
    MOV r2, 0001
    AND r3, r3, r2
    MOV r2, 1010
    SHIFTLEFT r2, 4
    MOV r2, 1000
    AND r4, r4, r2// bit mask to get   b4 b2 b1 bits
    ADD r4, r3, r4
    XORR r4, 0, r4
    MOV r2, 0000
    SHIFTLEFT r2, 4
    MOV r2, 0001
    AND r4, r4, r2
    SHIFTLEFT r4, r4, 1
    MOV r2, 0001
    SHIFTLEFT r2, 4
    MOV r2, 1110 //LOADs the incomplete LSW from memory
    LOAD r3, r1, r1
    ADD r3, r3, r4 //b4 b3 b2 p4 b1 p2 p1 _ is now in a register

    MOV r2, 0001
    SHIFTLEFT r2, 4
    MOV r2, 1111
    LOAD r4, r1, r2
    XORR r4, 0, r4
    MOV r2, 0000
    SHIFTLEFT r2, 4
    MOV r2, 0001
    AND r4, r4, r2
    ADD r4, r3, r4
    XORR r3,0, r4 // b4 b3 b2 p4 b1 p2 p1 16 is now in a register
    STORE r3, r1, r2
    ADD r1, r1, 2
    BOE r1, r1,
exit: 
    halt