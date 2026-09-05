`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2026 19:04:42
// Design Name: 
// Module Name: line_buffer
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


module line_buffer #(
    parameter DATA_WIDTH = 8,
    parameter IMG_WIDTH  = 640
)(
    input  wire                   clk,
    input  wire                   rst,
    input  wire [DATA_WIDTH-1:0]  pixel_in,
    input  wire                   valid_in,

    output reg  [DATA_WIDTH-1:0]  row1_out,
    output reg  [DATA_WIDTH-1:0]  row2_out
);

    reg [DATA_WIDTH-1:0] line1 [0:IMG_WIDTH-1];
    reg [DATA_WIDTH-1:0] line2 [0:IMG_WIDTH-1];

    reg [$clog2(IMG_WIDTH)-1:0] col_cnt;

    always @(posedge clk) begin
        if (rst) begin
            col_cnt <= 0;
        end 
        else if (valid_in) begin

            // shift down rows
            line1[col_cnt] <= pixel_in;
            line2[col_cnt] <= line1[col_cnt];

            // output taps
            row1_out <= line1[col_cnt];
            row2_out <= line2[col_cnt];

            // column counter
            if (col_cnt == IMG_WIDTH-1)
                col_cnt <= 0;
            else
                col_cnt <= col_cnt + 1;
        end
    end

endmodule
