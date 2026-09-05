`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2026 23:31:33
// Design Name: 
// Module Name: cmp2
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


module cmp2 #(
    parameter DATA_WIDTH = 8
)(
    input  wire [DATA_WIDTH-1:0] a,
    input  wire [DATA_WIDTH-1:0] b,

    output wire [DATA_WIDTH-1:0] min,
    output wire [DATA_WIDTH-1:0] max
);

    assign min = (a <= b) ? a : b;
    assign max = (a <= b) ? b : a;

endmodule

