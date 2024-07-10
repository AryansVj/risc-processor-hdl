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
    output p,q,u,v,w,
    output cc, reg_d, reg_s, op, reg_t, imm, off
    );
    
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

endmodule
