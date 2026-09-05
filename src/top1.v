`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Student 
// Engineer: Pratik
// 
// Create Date: 21.02.2026 23:09:21
// Design Name: Median_Filter
// Module Name: top1
// Project Name: 3x3_Median_Filter
// Target Devices: FPGA
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


module top1 #(
    parameter DATA_WIDTH = 8,
    parameter IMG_WIDTH  = 5
)(
    input  wire                   clk,
    input  wire                   rst,
    input  wire                   valid_in,
    input  wire [DATA_WIDTH-1:0]  pixel_in,

    output wire                   valid_out,
    output wire [DATA_WIDTH-1:0]  pixel_out
);

    //-----------------------------
    // Column / Row Counters
    //-----------------------------
    reg [$clog2(IMG_WIDTH)-1:0] col_cnt;
    reg [15:0] row_cnt;

    always @(posedge clk) begin
        if (rst) begin
            col_cnt <= 0;
            row_cnt <= 0;
        end
        else if (valid_in) begin

            if (col_cnt == IMG_WIDTH-1) begin
                col_cnt <= 0;
                row_cnt <= row_cnt + 1;
            end
            else begin
                col_cnt <= col_cnt + 1;
            end

        end
    end


    //-----------------------------
    // Line Buffer
    //-----------------------------
    wire [DATA_WIDTH-1:0] row1_raw;
    wire [DATA_WIDTH-1:0] row2_raw;

    line_buffer #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH)
    ) lb (
        .clk      (clk),
        .rst      (rst),
        .pixel_in (pixel_in),
        .valid_in (valid_in),
        .row1_out (row1_raw),
        .row2_out (row2_raw)
    );


//-----------------------------
// Alignment Registers (Final Correct Version)
//-----------------------------
reg [DATA_WIDTH-1:0] bot_d1, bot_d2;
reg [DATA_WIDTH-1:0] mid_d1, mid_d2;

always @(posedge clk) begin
    if (rst) begin
        bot_d1 <= 0;
        bot_d2 <= 0;

        mid_d1 <= 0;
        mid_d2 <= 0;
    end
    else if (valid_in) begin

        // Bottom row delay = 2
        bot_d1 <= pixel_in;
        bot_d2 <= bot_d1;

        // Middle row delay = 2
        mid_d1 <= row1_raw;
        mid_d2 <= mid_d1;

    end
end


    //-----------------------------
    // 3x3 Window
    //-----------------------------
    wire [DATA_WIDTH-1:0] w0,w1,w2;
    wire [DATA_WIDTH-1:0] w3,w4,w5;
    wire [DATA_WIDTH-1:0] w6,w7,w8;

    window_3x3 #(
        .DATA_WIDTH(DATA_WIDTH)
    ) win (
        .clk      (clk),
        .rst      (rst),
        .valid_in (valid_in),

        .pixel_in(bot_d2),
        .row1_in (mid_d2),
        .row2_in  (row2_raw),

        .w0(w0), .w1(w1), .w2(w2),
        .w3(w3), .w4(w4), .w5(w5),
        .w6(w6), .w7(w7), .w8(w8)
    );


    //-----------------------------
    // Median Filter
    //-----------------------------
    median9 #(
        .DATA_WIDTH(DATA_WIDTH)
    ) median_inst (
        .d0(w0), .d1(w1), .d2(w2),
        .d3(w3), .d4(w4), .d5(w5),
        .d6(w6), .d7(w7), .d8(w8),

        .median(pixel_out)
    );


    //-----------------------------
    // Valid Alignment (4-cycle delay total)
    //-----------------------------
    reg valid_d1, valid_d2, valid_d3, valid_d4;

    always @(posedge clk) begin
        if (rst) begin
            valid_d1 <= 0;
            valid_d2 <= 0;
            valid_d3 <= 0;
            valid_d4 <= 0;
        end
        else begin
            valid_d1 <= (row_cnt >= 2) && (col_cnt >= 2);
            valid_d2 <= valid_d1;
            valid_d3 <= valid_d2;
            valid_d4 <= valid_d3;
        end
    end

    assign valid_out = valid_d4;

endmodule
