`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2024 03:13:52 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input clk, rst,
    input wire [31:0] dm_in,
    input wire [13:0] addr,
    input wire writeEn,
    output reg [31:0] dm_out
    );

    reg [31:0] memory [2047:0];

    always @(posedge clk) begin
        if (writeEn) begin
            memory[addr] <= dm_in;
        end
        else begin
            dm_out <= memory[addr];
        end
    end

endmodule
