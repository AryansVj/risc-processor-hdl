`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2024 08:16:13 PM
// Design Name: 
// Module Name: IR_decode
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


module IR_decode(
    input clk, rst,
    input [31:0] IRin,
    input wire N, Z, C, V, S,
    output wire p, q, u, v, w, 
    output wire [2:0] cc, 
    output wire [3:0] reg_d, reg_s, reg_t, op, 
    output wire [15:0] imm, 
    output wire [19:0] off,
    output wire MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV, LDW, STW, BR,
    output wire stall, dmwr,
    output reg stall1
    );

    wire stallL;
    
    assign p = IRin[31];
    assign q = IRin[30];
    assign u = IRin[29];
    assign v = IRin[28];
    assign w = IRin[16];
    
    assign cc = IRin[26:24];
    assign reg_d = IRin[27:24];     // Destination register addr
    assign reg_s = IRin[23:20];     // Source Register addr
    assign op = IRin[19:16];
    assign reg_t = IRin[3:0];       // Target register addr
    assign imm = IRin[15:0];
    assign off = IRin[19:0];

    // Register Instructions
    assign MOV = ~p & (op==0);
    assign LSL = ~p & (op==1);
    assign ASR = ~p & (op==2);
    assign ROR = ~p & (op==3);
    assign AND = ~p & (op==4);
    assign ANN = ~p & (op==5);
    assign IOR = ~p & (op==6);
    assign XOR = ~p & (op==7);
    assign ADD = ~p & (op==8);
    assign SUB = ~p & (op==9);
    assign MUL = ~p & (op==10);
    assign DIV = ~p & (op==11);

    // Memory Instructions
    assign LDW = p & ~q & ~u;
    assign STW = p & ~q & u;
    assign dmwr = (STW==1);
    
    // Branch Instructions
    assign BR = p & q;

    // Stalling signal to retain same instruction in PC for LDW
    assign stall = stallL;
    assign stallL = LDW & ~stall1;
    always @(posedge clk) begin 
        stall1 <= stallL; 
    end

    // Branch condition
    assign cond = IRin[27] ^ ((cc==0) & N | (cc==1) & Z | (cc==2) & C | (cc==3) & V | (cc==4) & (C|Z) | (cc==5) & S | (cc==6) & (S|Z) | (cc==7));
endmodule
