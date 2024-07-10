# Documentation and Notes
32 bit word size. 32 bit architecture. 16 Registers
## Instruction Architecture
**There are three types of instructions**
1. Register Instructions (R-type)
2. Memory Instructions (I-type)
3. Branch Instructions (J-type)

**Register Instructions** - (Also called r-type in MIPS ISA) These instructions are structured with 3 register numbers, two specifying the operands (sources), one the result (destination). Thus we obtain a 3-address computer. 
- Logical operations - AND, OR, XOR
- Arithmetic operations - ADD, SUBTRACT, (MULTIPLY), (DIVIDE)
- Shift - Rotation (LSL and ASR)
![R-type Instruction formats](/Docs/images/R-type_instruction_formats.png)

**Memory Instructions** - (Also called i-type in MIPS ISA) These instructions correspond to processor-memory interactions. Load and Store instructions are managed using them. Utilize register value together with an immediate value (offset) to specify the memory address

**Branch Instructions** - (Also called j-type in MIPS ISA) These instructions are used to jump between instructions in the instruction memory. Also called control instructions. 

### Decoding Instructons
**OPCODE** : `pquv`
- pq == 00 : R-type instruction of F0 format
- pq == 01 : R-type instruction of F1 format
- pq == 10 : I-type (Memory) instructions of F2 format; 
    - u = 0 : load; u = 1 : store
    - v = 0 : word addressing; v = 1 : byte addressing
- pq == 11 : J-type (Branch) Instructions of F3 format
    - u = 0 : PC = Rt; u = 1 : PC = 1 + offset
    - v = 0 : no link; v = 1 : R15 (link reg) := PC+1

## Modules in the RISC - 0 architecture
we stick to the following scheme, where a module consists of 4 parts:
1. The header with the list of input and output signals (parameters)
2. The declaration part, introducing the names of signals (wires) and registers
3. The assignments of (Boolean) values to signals (wires)
4. The assignments to registers (at the positive clk edge)
![Module Structure](/Docs/images/module_structure.png)

#### IR_decode
`IR_decode.v` - Decoding the Instructions stored in the Instruction Register
- inputs: 
    1. Clock (clk) and Reset (rst)
    2. Instruction (32 bit value)
- outputs: 
    1. p,q,u,v (Instruction ID/opcode)
    2. w, cc, 
    3. op (Opcode)
    4. reg_d, reg_s, reg_t (Register addresses of Destination, Source, Target)
    5. imm, off (Immediate and offset values)
    6. MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV, LDW, TW, BR (Operation keywords asserted according to decoded Instruction)