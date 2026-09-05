`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 23:13:26
// Design Name: 
// Module Name: top1_TB
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

module top1_TB;

// ================================
// Image Size (MUST match Python)
// ================================
parameter DATA_WIDTH = 8;
parameter IMG_WIDTH  = 64;
parameter IMG_HEIGHT = 64;

// ================================
// Signals
// ================================
reg clk;
reg rst;
reg valid_in;
reg [DATA_WIDTH-1:0] pixel_in;

wire valid_out;
wire [DATA_WIDTH-1:0] pixel_out;

integer i;
integer outfile;

// ================================
// Clock Generation (100 MHz)
// ================================
always #5 clk = ~clk;

// ================================
// DUT Instantiation
// ================================
top1 #(
    .DATA_WIDTH(DATA_WIDTH),
    .IMG_WIDTH (IMG_WIDTH)
) dut (
    .clk(clk),
    .rst(rst),
    .valid_in(valid_in),
    .pixel_in(pixel_in),
    .valid_out(valid_out),
    .pixel_out(pixel_out)
);

// ================================
// Image Memory
// ================================
reg [DATA_WIDTH-1:0] image_mem [0:IMG_WIDTH*IMG_HEIGHT-1];

// ================================
// Simulation
// ================================
initial begin

    clk = 0;
    rst = 1;
    valid_in = 0;
    pixel_in = 0;

    // Load image file
    $readmemh("C:/Desktop/Median_Filter/image.mem", image_mem);

    // Open output file
    outfile = $fopen("C:/Desktop/Median_Filter/filtered.mem", "w");

    #50;
    rst = 0;
    #20;

    valid_in = 1;

    // Stream all pixels
    for (i = 0; i < IMG_WIDTH*IMG_HEIGHT; i = i + 1) begin
        pixel_in = image_mem[i];
        #10;
    end

    valid_in = 0;

    // Allow pipeline to flush
    #5000;

    $fclose(outfile);

    $display("=================================");
    $display("   Filtering Complete!");
    $display("=================================");

    $stop;

end

// ================================
// Write Filtered Output
// ================================
always @(posedge clk) begin
    if (valid_out) begin
        $fwrite(outfile, "%02x\n", pixel_out);
    end
end

endmodule