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
    output p, q, u, v, w, cc, reg_d, reg_s, op, reg_t, imm, off,
    output MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV, LDW, STW, BR
    );

    wire MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV;
    wire LDW, STW;
    wire BR;
    
    wire p = IRin[31];
    wire q = IRin[30];
    wire u = IRin[29];
    wire v = IRin[28];
    wire w = IRin[16];
    
    wire cc = IRin[26:24];
    wire reg_d = IRin[27:24];     // Destination register addr
    wire reg_s = IRin[23:20];     // Source Register addr
    wire op = IRin[19:16];
    wire reg_t = IRin[3:0];       // Target register addr
    wire imm = IRin[15:0];
    wire off = IRin[19:0];

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
    
    // Branch Instructions
    assign BR = p & q;

endmodule
