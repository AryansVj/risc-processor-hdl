`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2024 09:40:40 PM
// Design Name: 
// Module Name: reg_bank
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

module reg_bank(
    input clk, rst,
    input writeEn,
    input [3:0] reg_d, reg_s, reg_t,
    input [31:0] dest_Din,
    output reg [31:0] src_Dout, tgt_Dout
    );

    // Register bank of the Set of 16 registers
    reg [31:0] REGISTER_BANK [0:15];
    
    // Reset the register bank content on rst
    integer i;
    always @(posedge clk or posedge rst) begin 
        if (rst) begin 
            for (i=0;i<16;i=i+1) begin
                REGISTER_BANK[i] <= 32'b0;
            end
        end
    end

    // Writing to and Reading from Registers in the bank
    always @(posedge clk) begin
        if (writeEn == 1) begin
            REGISTER_BANK[reg_d] <= dest_Din;
        end
        src_Dout <= REGISTER_BANK[reg_s];
        tgt_Dout <= REGISTER_BANK[reg_t];
    end
    
endmodule
