`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2026 00:19:39
// Design Name: 
// Module Name: median9
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
module median9 #(
    parameter DATA_WIDTH = 8
)(
    input  wire [DATA_WIDTH-1:0] d0,d1,d2,d3,d4,d5,d6,d7,d8,
    output wire [DATA_WIDTH-1:0] median
);

    // Stage wires
    wire [DATA_WIDTH-1:0]
        a0,a1,a2,a3,a4,a5,a6,a7,a8,
        b0,b1,b2,b3,b4,b5,b6,b7,b8,
        c0,c1,c2,c3,c4,c5,c6,c7,c8,
        d00,d01,d02,d03,d04,d05,d06,d07,d08,
        e0,e1,e2,e3,e4,e5,e6,e7,e8;

    // -------- Stage 1 --------
    cmp2 s10(d0,d1,a0,a1);
    cmp2 s11(d2,d3,a2,a3);
    cmp2 s12(d4,d5,a4,a5);
    cmp2 s13(d6,d7,a6,a7);
    assign a8 = d8;

    // -------- Stage 2 --------
    cmp2 s20(a1,a2,b1,b2);
    cmp2 s21(a3,a4,b3,b4);
    cmp2 s22(a5,a6,b5,b6);
    cmp2 s23(a7,a8,b7,b8);
    assign b0 = a0;

    // -------- Stage 3 --------
    cmp2 s30(b0,b1,c0,c1);
    cmp2 s31(b2,b3,c2,c3);
    cmp2 s32(b4,b5,c4,c5);
    cmp2 s33(b6,b7,c6,c7);
    assign c8 = b8;

    // -------- Stage 4 --------
    cmp2 s40(c1,c2,d01,d02);
    cmp2 s41(c3,c4,d03,d04);
    cmp2 s42(c5,c6,d05,d06);
    cmp2 s43(c7,c8,d07,d08);
    assign d00 = c0;

    // -------- Stage 5 --------
    cmp2 s50(d00,d01,e0,e1);
    cmp2 s51(d02,d03,e2,e3);
    cmp2 s52(d04,d05,e4,e5);
    cmp2 s53(d06,d07,e6,e7);
    assign e8 = d08;

    // -------- Stage 6 --------
    wire [DATA_WIDTH-1:0] f0,f1,f2,f3,f4,f5,f6,f7,f8;

    cmp2 s60(e1,e2,f1,f2);
    cmp2 s61(e3,e4,f3,f4);
    cmp2 s62(e5,e6,f5,f6);
    cmp2 s63(e7,e8,f7,f8);
    assign f0 = e0;

    // -------- Stage 7 --------
    wire [DATA_WIDTH-1:0] g0,g1,g2,g3,g4,g5,g6,g7,g8;

    cmp2 s70(f0,f1,g0,g1);
    cmp2 s71(f2,f3,g2,g3);
    cmp2 s72(f4,f5,g4,g5);
    cmp2 s73(f6,f7,g6,g7);
    assign g8 = f8;

    // -------- Stage 8 --------
    wire [DATA_WIDTH-1:0] h0,h1,h2,h3,h4,h5,h6,h7,h8;

    cmp2 s80(g1,g2,h1,h2);
    cmp2 s81(g3,g4,h3,h4);
    cmp2 s82(g5,g6,h5,h6);
    cmp2 s83(g7,g8,h7,h8);
    assign h0 = g0;

    // -------- Output --------
    assign median = h4;

endmodule




