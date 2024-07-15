`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2024 08:49:38 PM
// Design Name: 
// Module Name: rs232_tx
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


module rs232_tx(
    input wire clk, rst,
    input wire start, // request to accept and send a byte
    input wire [7:0] data,
    output wire rdy, // status
    output wire TxD // serial data
    );

    wire endtick, endbit;
    reg run;
    reg [11:0] tick;
    reg [3:0] bitCount;
    reg [8:0] shift_reg;

    assign endtick = (tick==1823);
    assign endbit = (bitCount==9);
    assign rdy = ~run;
    assign TxD = shift_reg[0];

    always @(posedge clk) begin
        run <= (~rst | endtick & endbit) ? 0: start ? 1: run;
        tick <= (run & ~endbit) ? bitCount + 1: (endtick & endbit) ? 0: bitCount;
        shift_reg <= (~rst) ? 1: start ? {data, 1'b0}: endtick ? {1'b1, shift_reg[8:1]}: shift_reg;
    end
endmodule