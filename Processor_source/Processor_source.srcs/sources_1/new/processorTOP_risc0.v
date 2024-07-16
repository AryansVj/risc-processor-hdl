`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2024 08:43:35 PM
// Design Name: 
// Module Name: processorTOP_risc0
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

`include "processor_risc0.v"
`include "rs232_tx.v"
`include "rs232_rx.v"

module processorTOP_risc0(
    input CLK50M,
    input rstln,
    input RxD,
    input [7:0] switches,
    output TxD,
    output [7:0] leds
    );

    wire clk, clkLocked;
    reg rst;

    wire [5:0] IO_addr;
    wire [3:0] IO_waddr;
    wire IO_wr, IO_rd;
    wire [31:0] inbus, outbus;

    wire [7:0] dataTx, dataRx;
    wire rdyRx, doneRx, startTx, rdyTx;
    wire limit;     // of count0

    reg [7:0] Lreg;
    reg [15:0] count0;
    reg [31:0] count1;   // Milliseconds

    processor_risc0 riscx (.clk(clk), .rst(rst), .rd(IO_rd), .wr(IO_wr), .IOaddr(IO_addr), .inbus(inbus), .outbus(outbus));

    rs232_rx serial_rx (.clk(clk), .rst(rst), .done(doneRx), .data(dataRx), .rdy(rdyRx), .RxD(RxD));
    rs232_tx serial_tx (.clk(clk), .rst(rst), .start(startTx), .data(dataTx), .rdy(rdyTx), .TxD(TxD));

    assign IO_waddr = IO_addr[5:2];
    assign inbus = 
        (IO_waddr==0) ? count1: 
        (IO_waddr==1) ? switches :
        (IO_waddr==2) ? {24'b0, dataRx} :
        (IO_waddr==3) ? {30'b0, rdyTx, rdyRx} : 0;

    assign dataTx = outbus[7:0];
    assign startTx = IO_wr & (IO_waddr==2);
    assign doneRx = IO_rd & (IO_waddr==2);
    assign limit = (count0==35000);
    assign leds = Lreg;

    always @(posedge clk) begin
        rst <= ~rstln & clkLocked;
        Lreg <= ~rst ? 0: (IO_wr & (IO_waddr==1)) ? outbus[7:0]: Lreg;
        count0 <= limit ? 0: count0 + 1;
        count1 <= limit ? count1 + 1: count1;
    end

endmodule
