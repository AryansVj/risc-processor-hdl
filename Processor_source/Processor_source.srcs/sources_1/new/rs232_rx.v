`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2024 08:50:05 PM
// Design Name: 
// Module Name: rs232_rx
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


module rs232_rx(
    input wire clk, rst,
    input wire done, // request to accept and send a byte
    input wire [7:0] data,
    output wire rdy, // status
    output wire RxD // serial data
    );

    wire endtick, midtick;
    reg run, stat;
    reg Q0, Q1;     // synchronizer and edge detector
    reg [11:0] tick;
    reg [3:0] bitCount;
    reg [7:0] shift_reg;

    assign endtick = (tick==1823);
    assign midtick = (tick==911);
    assign endbit = (bitCount==8);
    assign data = shift_reg;
    assign rdy = stat;

    always @(posedge clk) begin
        Q0 <= RxD; Q1 <= Q0;
        run <= (Q1 & ~Q0) ? 1 : (~rst | endtick & endbit) ? 0 : run;
        tick <= (run & ~endtick) ? tick + 1 : 0;
        bitCount <= (endtick & ~endbit) ? bitCount + 1 :
        (endtick & endbit) ? 0 : bitCount;
        shift_reg <= midtick ? {Q1, shift_reg[7:1]} : shift_reg;
        stat <= (endtick & endbit) ? 1 : (~rst | done) ? 0 : stat;
    end
endmodule
