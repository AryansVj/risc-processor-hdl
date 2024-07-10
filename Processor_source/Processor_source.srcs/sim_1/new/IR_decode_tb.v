`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2024 09:18:22 PM
// Design Name: 
// Module Name: IR_decode_tb
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

`include "Processor_source\Processor_source.srcs\sources_1\new\IR_decode.v"
module IR_decode_tb();
    reg CLK;
    wire RST = 0;
    reg [31:0] instruction;
    wire p, q, u, v, w, cc, reg_d, reg_s, op, reg_t, imm, off;
    wire MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV, LDW, STW, BR;

    initial begin
    CLK <= 0;
    forever begin
        #10;
        CLK <= ~CLK;
    end
    end

    IR_decode IR(
        CLK, RST, instruction,
        p, q, u, v, w, cc, reg_d, reg_s, op, reg_t, imm, off,
        MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV, LDW, STW, BR
    );

    always @(posedge CLK) begin
        instruction <= 32'hd8;
        $display("op: %b | Dest Reg: %b", op, reg_d);
        #10000;
    end

endmodule
