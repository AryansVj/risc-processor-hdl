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


`timescale 1ns/1ps

module reg_bank(
    input clk, rst,
    input [0:15] registers,
    input writeEn,
    input [3:0] reg_d, reg_s, reg_t,
    input [31:0] dest_Din,
    output reg [31:0] src_Dout, tgt_Dout
    );

    reg [31:0] REG_BANK [0:15];
    integer i,j;

    always @(posedge clk or posedge rst) begin 
        if (rst) begin 
            for (i=0;i<16;i=i+1) begin
                REG_BANK[i] <= 32'b0;
            end
        end
        else begin
            for (j=0;j<16;j=j+1) begin
                REG_BANK[j] = registers[j];
                $display ("Content of REGBank %d is %b", i, REG_BANK[i]);
            end
        end
    end

    always @(posedge clk) begin
        if (writeEn == 1) begin
            REG_BANK[reg_d] <= dest_Din;
        end
        else begin
            src_Dout <= REG_BANK[reg_s];
            tgt_Dout <= REG_BANK[reg_t];
        end
    end
    
endmodule
