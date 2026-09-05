`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2026 23:32:57
// Design Name: 
// Module Name: cmp2_TB
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

module cmp2_TB;

    reg  [7:0] a, b;
    wire [7:0] min, max;

    // DUT
    cmp2 dut (
        .a(a),
        .b(b),
        .min(min),
        .max(max)
    );

    initial begin

        a = 10; b = 20; #10;
        a = 50; b = 30; #10;
        a = 15; b = 15; #10;
        a = 0;  b = 255;#10;

        $stop;
    end

endmodule

