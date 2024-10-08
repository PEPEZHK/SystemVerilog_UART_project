`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2024 18:52:12
// Design Name: 
// Module Name: four_rx_tb
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


`timescale 1ns / 1ps

module four_byte_rx_tb;

    // Parameters
    parameter BAUD_RATE = 115200;
    parameter CYCLE_PER_BIT = 870;

    // Signals
    logic clk;
    logic act;
    logic bit_to_put;
    logic [7:0] data;
    logic [31:0] rxbuf;

    // Instantiate the module
    four_byte_rx dut (
        .clk(clk),
        .act(act),
        .bit_to_put(bit_to_put),
        .data(data),
        .rxbuf(rxbuf)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        clk = 0;
        /*act = 1; // Example value for act
        bit_to_put = 0; // Example value for bit_to_put

        #100; // Allow some time for initialization

        // Test scenario 1: Send a byte with all bits high
        act = 1;
        bit_to_put = 0;
        #100; // Wait for transmission to complete

        // Test scenario 2: Send a byte with all bits low
        act = 1;
        bit_to_put = 1;
        #100; // Wait for transmission to complete

        // Test scenario 3: Send alternating bits
        act = 1;
        $display("%b" , rxbuf) ;
        for (int i = 0; i < 8; i = i + 1) begin
            bit_to_put = i % 2;
            #100; // Wait for transmission to complete
        end

        // Test scenario 4: Toggle act signal during transmission
        act = 1;
        bit_to_put = 1;
        #50; // Start transmission
        act = 1; // Deactivate transmission
        #100; // Wait for transmission to complete

        // Test scenario 5: Vary bit_to_put signal during transmission
        act = 1;
        for (int i = 0; i < 8; i = i + 1) begin
            bit_to_put = i % 2;
            #50; // Wait for half a bit period
            bit_to_put = ~bit_to_put; // Toggle bit_to_put signal
            #50; // Wait for another half a bit period
        end
        #100; // Wait for transmission to complete

        // Finish simulation after some time
        #1000;*/
         bit_to_put = 1'b0; // Example bit sequence
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1; // Example bit sequence
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
        #100;
         bit_to_put = 1'b1; // Example bit sequence
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1; // Example bit sequence
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;bit_to_put = 1'b1; // Example bit sequence
         #100;
         bit_to_put = 1'b0;
        #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1; // Example bit sequence
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1; // Example bit sequence
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
        bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1; // Example bit sequence
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100;
         bit_to_put = 1'b0;
         #100;
         bit_to_put = 1'b1;
         #100
         $display("%b" , rxbuf) ;
        $finish;
    end

endmodule


