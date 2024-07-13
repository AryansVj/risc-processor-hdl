`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2024 03:57:57 PM
// Design Name: 
// Module Name: prog_mem
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


module prog_mem(
    input clk, rst,
    input wire [11:0] pcmux,
    output wire [31:0] pm_out
    );

    reg [31:0] program_mmemory [2047:0];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i=0; i<2048; i=i+1) begin
                program_mmemory[i] <= 32'b0;
            end
        end
    end

    assign pm_out = program_mmemory[pcmux];     // Instruction

endmodule
