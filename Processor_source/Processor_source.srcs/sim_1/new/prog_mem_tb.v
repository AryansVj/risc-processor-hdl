`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2024 04:08:33 PM
// Design Name: 
// Module Name: prog_mem_tb
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

`include "Processor_source\Processor_source.srcs\sources_1\new\prog_mem.v"

module prog_mem_tb();
    reg CLK, RST;
    wire [31:0] pm_out;
    reg [11:0] pcmux;
    
    initial begin
    CLK <= 0;
    forever begin
        #10;
        CLK <= ~CLK;
    end
    end

    prog_mem PM(.clk(CLK), .rst(RST), .pcmux(pcmux), .pm_out(pm_out));

    initial begin
        RST <= 1;
        #10;
        $display("RST set to %b", RST);
        RST <= 0;
        #10;
        pcmux <= 12'd45;
        #10;
        $display("RST set to 0; PCMUX is %d", pcmux);
        $display("Instruction %b", pm_out);
        $finish;
    end

endmodule
