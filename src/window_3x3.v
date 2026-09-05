`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2026 19:06:09
// Design Name: 
// Module Name: window_3x3
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


module window_3x3 #(
    parameter DATA_WIDTH = 8
)(
    input  wire clk,
    input  wire rst,
    input  wire valid_in,

    input  wire [DATA_WIDTH-1:0] pixel_in,
    input  wire [DATA_WIDTH-1:0] row1_in,
    input  wire [DATA_WIDTH-1:0] row2_in,

    output reg  [DATA_WIDTH-1:0] w0, w1, w2,
    output reg  [DATA_WIDTH-1:0] w3, w4, w5,
    output reg  [DATA_WIDTH-1:0] w6, w7, w8
);

    // shift registers for 3 columns
    always @(posedge clk) begin
        if (rst) begin
            {w0,w1,w2,w3,w4,w5,w6,w7,w8} <= 0;
        end
        else if (valid_in) begin

            // top row shift
            w0 <= w1;
            w1 <= w2;
            w2 <= row2_in;

            // middle row shift
            w3 <= w4;
            w4 <= w5;
            w5 <= row1_in;

            // bottom row shift
            w6 <= w7;
            w7 <= w8;
            w8 <= pixel_in;
        end
    end

endmodule

