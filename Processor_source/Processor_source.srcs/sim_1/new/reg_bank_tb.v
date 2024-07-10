`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2024 10:12:08 AM
// Design Name: 
// Module Name: reg_bank_tb
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

`include "Processor_source\Processor_source.srcs\sources_1\new\reg_bank.v"

module reg_bank_tb();
    reg CLK;
    wire RST = 0;
    wire writeEn = 1;
    reg [3:0] ADR_reg_d, ADR_reg_s, ADR_reg_t;
    reg [31:0] dest_Data;
    wire [31:0] src_Data, tgt_Data;

    initial begin
    CLK <= 0;
    forever begin
        #10;
        CLK <= ~CLK;
    end
    end

    assign RST = 0;
    initial begin
        ADR_reg_d <= 4'b0001;   // Destination address
        ADR_reg_s <= 4'b0001;   // Source address (same as dest to check)
        ADR_reg_t <= 4'b0011;
        dest_Data <= 32'hab;
    end

    reg_bank REG_BANK(
        .clk(CLK), .rst(RST), .writeEn(writeEn), 
        .reg_d(ADR_reg_d), .reg_s(ADR_reg_s), .reg_t(ADR_reg_t), 
        .dest_Din(dest_Data), .src_Dout(src_Data), .tgt_Dout(tgt_Data)
    );

    always @(posedge CLK) begin
        $display("source Reg %b", src_Data);
        #1000000;
    end
endmodule
