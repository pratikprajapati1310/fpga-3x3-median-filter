`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2026 00:27:04
// Design Name: 
// Module Name: median9_TB
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

module median9_TB;

    parameter DATA_WIDTH = 8;

    // DUT inputs
    reg  [DATA_WIDTH-1:0] a,b,c,d,e,f,g,h,i;
    wire [DATA_WIDTH-1:0] median_hw;

    // DUT (MATCHES d0..d8 PORTS)
    median9 #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .d0(a),
        .d1(b),
        .d2(c),
        .d3(d),
        .d4(e),
        .d5(f),
        .d6(g),
        .d7(h),
        .d8(i),
        .median(median_hw)
    );


    // Software reference
    reg [DATA_WIDTH-1:0] arr [0:8];
    reg [DATA_WIDTH-1:0] temp;

    integer x,y,k;

    reg [DATA_WIDTH-1:0] median_sw;


    initial begin

        // Run many random tests
        for (x = 0; x < 200; x = x + 1) begin

            // Random inputs
            a = $random;
            b = $random;
            c = $random;
            d = $random;
            e = $random;
            f = $random;
            g = $random;
            h = $random;
            i = $random;

            #1; // let combinational logic settle

            // Load into array
            arr[0]=a; arr[1]=b; arr[2]=c;
            arr[3]=d; arr[4]=e; arr[5]=f;
            arr[6]=g; arr[7]=h; arr[8]=i;

            // Bubble sort (reference model)
            for (y = 0; y < 9; y = y + 1) begin
                for (k = 0; k < 8; k = k + 1) begin
                    if (arr[k] > arr[k+1]) begin
                        temp      = arr[k];
                        arr[k]    = arr[k+1];
                        arr[k+1]  = temp;
                    end
                end
            end

            // Median = middle value
            median_sw = arr[4];

            // Compare
            if (median_hw !== median_sw) begin

                $display("ERROR!");
                $display("Inputs: %0d %0d %0d %0d %0d %0d %0d %0d %0d",
                          a,b,c,d,e,f,g,h,i);

                $display("HW median = %0d, SW median = %0d",
                          median_hw, median_sw);

                $stop;
            end
        end

        $display("=================================");
        $display("ALL TESTS PASSED!");
        $display("=================================");

        $stop;

    end

endmodule


