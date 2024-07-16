`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2024 07:46:58 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input clk, rst,
    input wire [31:0] src_Data, tgt_Data,
    input wire p, q, u, v, w,
    input wire [0:15] imm,
    input wire MOV, LSL, ASR, ROR, AND, ANN, IOR, XOR, ADD, SUB, MUL, DIV, LDW, STW, BR,
    input wire [0:3] reg_d,
    input wire stall, stall1,
    output reg [31:0] ALU_res
    );

    wire [31:0] tgt_Data0, product, quotient;
    wire [3:0] reg_d0;

    // Controll unit
    assign reg_d0 = BR ? 4'd15 : reg_d;     // Setting the Link register address if branching (regular reg_d addr unless)
    assign tgt_Data0 = ~q ? tgt_Data : {{16{v}}, imm};

    // For shifting carried out in 3 stages using 4 input MUX's
    wire [31:0] ls_res1, ls_res2, ls_res3;     // Intermdiate outputs of shifters
    wire [1:0] sc1, sc0;        // shift counts

    assign sc0 = tgt_Data0[1:0];
    assign sc1 = tgt_Data0[3:2];

    // Shifter for LSL
    assign ls_res1 = (sc0==3) ? {src_Data[28:0], 3'b0}:     // stage 1
        (sc0==2) ? {src_Data[29:0], 2'b0} :
        (sc0==1) ? {src_Data[30:0], 1'b0} : src_Data;
    assign ls_res2 = (sc1==3) ? {ls_res1[28:0], 12'b0}:     // stage 2
        (sc1==2) ? {ls_res1[29:0], 8'b0} :
        (sc1==1) ? {ls_res1[30:0], 4'b0} : ls_res1;
    assign ls_res3 = tgt_Data0[4] ? {ls_res2[15:0], 16'b0} : ls_res2;   // stage 3

    // Shifter for ASR and ROR
    wire [31:0] rsr_res1, rsr_res2, rsr_res3;
    assign rsr_res1 = (sc0==3) ? {(w ? src_Data[2:0] : {3{src_Data[31]}}), src_Data[31:3]} :    // stage 1
        (sc0 == 2) ? {(w ? src_Data[1:0] : {2{src_Data[31]}}), src_Data[31:2]} :
        (sc0 == 1) ? {(w ? src_Data[0] : src_Data[31]), src_Data[31:1]} : src_Data;

    assign rsr_res2 = (sc1 == 3) ? {(w ? rsr_res1[11:0] : {12{rsr_res1[31]}}), rsr_res1[31:12]} :   // stage 2
        (sc1 == 2) ? {(w ? rsr_res1[7:0] : {8{rsr_res1[31]}}), rsr_res1[31:8]} :
        (sc1 == 1) ? {(w ? rsr_res1[3:0] : {4{rsr_res1[31]}}), rsr_res1[31:4]} : rsr_res1;

    assign rsr_res3 = tgt_Data0[4] ? {(w ? rsr_res2[15:0] : {16{rsr_res2[31]}}), rsr_res2[31:16]} : rsr_res2;   // stage 3
    
    always @(*) begin
    // ALU Operations 
        ALU_res = MOV ? tgt_Data0 :
            LSL ? ls_res3 :
            ASR ? rsr_res3 :
            ROR ? rsr_res3 :
            AND ? src_Data & tgt_Data0 :
            ANN ? src_Data & ~tgt_Data0 :
            IOR ? src_Data | tgt_Data0 :
            XOR ? src_Data ^ tgt_Data0 :
            ADD ? src_Data + tgt_Data0 + (u & tgt_Data) :
            SUB ? src_Data - tgt_Data0 - (u & tgt_Data) :
            MUL ? product[31:0] :
            DIV ? quotient : 0;        
    end

endmodule
