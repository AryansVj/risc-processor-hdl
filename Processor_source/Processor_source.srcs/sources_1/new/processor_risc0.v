`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2024 01:41:56 PM
// Design Name: 
// Module Name: processor_risc0
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "IR_decode.v"
`include "data_mem.v"
`include "prog_mem.v"
`include "PC.v"
`include "reg_bank.v"
`include "ALU.v"

module processor_risc0(
    input wire clk, rst,
    input wire [31:0] inbus,
    output wire [5:0] IOaddr,
    output wire rd, wr,
    output wire [31:0] outbus
    );

    wire [11:0] ADDR_prog, ADDR_dm; // Program and Data memory addresses
    wire regwr, dmwr;               // Register and Data mem write enable signals
    wire [3:0] reg_d, reg_s, reg_t; // Register addresses of destination, source and target
    wire [31:0] dest_Data;          // Data from memory to register reg_d
    wire [31:0] src_Data, tgt_Data; // Data from registers
    wire [11:0] pcmux, nxpc;        // PC-MUX selecting the address to PC
    wire [31:0] IR;                 // Instruction
    wire MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV, LDW, STW, BR;  // Instruction OPCODEs
    // Decoded IR flags and conditions
    wire p, q, u, v, w; 
    wire [2:0] cc; wire [3:0] op; wire [15:0] imm; wire [19:0] off;
    wire [31:0] ALU_res;
    wire [31:0] dm_out;
    wire cond;          // Branch conditions from ALU
    wire IOenb;         // Guess IO enable
    reg [31:0] regmux;
    reg N, Z, C, V, S;  // Flags

    // DATA MEMORY - 2K Memory Block for data (BRAM 1)
    data_mem DATA_MEM (.clk(clk), .rst(rst), .dm_in(src_Data), .addr(ADDR_dm), .writeEn(dmwr), .dm_out(dm_out));

    //////////// CONTROL UNIT
    // PROGRAM MEMORY - 2K Memory block for instructions (BRAM 2)
    prog_mem PROG_MEM (.clk(clk), .rst(rst), .pcmux(pcmux), .pm_out(IR));
    // PROGRAM COUNTER - Incrementing the Program Mem address for next instruction
    pc PC (.clk(clk), .rst(rst), .tgt_Data(tgt_Data), .BR(BR), .cond(cond), .u(u), .stall(stall), .off(off), .PC(ADDR_prog));
    // Instruction Decoding
    IR_decode IR_DECODE (
        clk, rst,
        IR,
        N, Z, C, V, S,
        p, q, u, v, w, cc, reg_d, reg_s, reg_t, op, imm, off,
        MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV, LDW, STW, BR,
        stall, dmwr, stall1
    );

    //////////// COMPUTATION UNIT
    // REGISTER BANK - Set 16 of registers
    reg_bank REG_BANK (.clk(clk), .rst(rst), .writeEn(regwr), .reg_d(reg_d), .reg_s(reg_s), .reg_t(reg_t), .dest_Din(dest_Data), .src_Dout(src_Data), .tgt_Dout(tgt_Data));
    // ARITHMATIC AND LOGIC UNIT - Computations
    ALU ALU (
        clk, rst,
        src_Data, tgt_Data,
        p, q, u, v, w,
        imm,
        MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV, LDW, STW, BR,
        reg_d, stall, stall1, ALU_res
    );

    // REG MUX - Data selection unit for destination data to the Reg
    always @(*) begin
        regmux = 
            (LDW & ~IOenb) ? dm_out :                    // Sending loaded content from dm to reg_bank
            (LDW & IOenb) ? inbus : 
            (BR & v) ? {18'b0, nxpc, 2'b0} : ALU_res;   // Sending next PC to link register

        // Predicate conditions
        N <= regwr ? regmux[31] : N;        // Sign flag
        Z <= regwr ? (regmux == 0) : Z;     // Zero flag
    end

    // Register write enable
    assign regwr = (~p & ~stall) | (LDW & ~stall & ~stall1) | (BR & cond & v);

endmodule
