`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2024 03:05:07 PM
// Design Name: 
// Module Name: pc
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


module pc(
    input wire clk, rst,
    input wire [31:0] tgt_Data,
    input wire BR, cond, u, stall,
    input wire [19:0] off,
    output reg [11:0] PC
    );
    
    reg [11:0] nxpc; 

    always @(posedge clk) begin
        nxpc = PC+1;
        PC <= (~rst) ? 0 :
            (stall) ? PC :
            (BR & cond & u) ? off[11:0] + nxpc :
            (BR & cond & ~u) ? tgt_Data[13:2] : nxpc;
    end
    
endmodule
