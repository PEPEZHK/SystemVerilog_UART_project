`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2024 19:02:52
// Design Name: 
// Module Name: rx_tb
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


module rx_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Signals
    reg clk;
    reg bit_to_put;
    reg [8:0] data;

    // Instantiate rx module
    rx rx_inst (
        .clk(clk),
        .bit_to_put(bit_to_put),
        .data(data)
    );
    // Clock generation
    always #870 clk = ~clk;

    // Stimulus
    initial begin
        // Initialize clock
        clk = 0;
        //clk = 1 ;
        // Reset values
        bit_to_put = 0;
        #5;

        // Test case 1: Sending valid data
        // Start bit
        bit_to_put = 1;
        #(870); // Wait for start bit duration

        // Data bits
        bit_to_put = 0; // Example: sending 01010101
        #(870); // Wait for data bits duration

        // Parity bit (example parity: 0)
        bit_to_put = 0;
        #(870); // Wait for parity bit duration

        // Stop bit
        bit_to_put = 1;
        #(870); // Wait for stop bit duration

        // Test case 2: Sending invalid parity
        // Start bit
        bit_to_put = 1;
        #(870); // Wait for start bit duration

        // Data bits
        bit_to_put = 0; // Example: sending 01010101
        #(870); // Wait for data bits duration

        // Parity bit (example parity: 1)
        bit_to_put = 1;
        #(870); // Wait for parity bit duration

        // Stop bit
        bit_to_put = 1;
        #(870); // Wait for stop bit duration

        // Add more test cases as needed

        // Finish simulation
        $finish;
    end

endmodule

