`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2024 11:59:21
// Design Name: 
// Module Name: tb
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


module beforeTransmission_tb;

  // Inputs
  logic clk = 0 ;
  logic btn_load = 0 ;
  logic btn_tr = 0 ;
  logic [7:0] data = 8'b00000000;

  // Outputs
  logic [8:0] data_cur;
  logic transmit;

  // Instantiate the module
  beforeTransmission dut (
    .clk(clk),
    .btn_load(btn_load),
    .btn_tr(btn_tr),
    .data(data),
    .data_cur(data_cur),
    .transmit(transmit)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Test scenario
  initial begin
    // Load data and trigger transmission
    data = 8'b00001111 ;
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_tr = 1;
    #5;
    btn_tr = 0;

    // Observe outputs
    $display("Data with parity bit: %b", data_cur);
    $display("Transmit signal: %b", transmit);

    // End simulation
    #10;
    data = 8'b00001011 ;
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_tr = 1;
    #5;
    btn_tr = 0;

    // Observe outputs
    $display("Data with parity bit: %b", data_cur);
    $display("Transmit signal: %b", transmit);

    // End simulation
    #10;
    data = 8'b00011110 ;
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_tr = 1;
    #5;
    btn_tr = 0;

    // Observe outputs
    $display("Data with parity bit: %b", data_cur);
    $display("Transmit signal: %b", transmit);

    // End simulation
    #10;
    data = 8'b11010000 ;
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_tr = 1;
    #5;
    btn_tr = 0;

    // Observe outputs
    $display("Data with parity bit: %b", data_cur);
    $display("Transmit signal: %b", transmit);

    // End simulation
    #10;
    data = 8'b01111110 ;
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_tr = 1;
    #5;
    btn_tr = 0;

    // Observe outputs
    $display("Data with parity bit: %b", data_cur);
    $display("Transmit signal: %b", transmit);

    // End simulation
    #10;
    #10;
    data = 8'b11111100 ;
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_tr = 1;
    #5;
    btn_tr = 0;

    // Observe outputs
    $display("Data with parity bit: %b", data_cur);
    $display("Transmit signal: %b", transmit);
    #10
    data = 8'b11010000 ;
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_tr = 1;
    #5;
    btn_tr = 0;

    // Observe outputs
    $display("Data with parity bit: %b", data_cur);
    $display("Transmit signal: %b", transmit);

    // End simulation
    #10;
    $finish;
  end

endmodule
/*module tx_tb;

  // Inputs
  logic clk = 0;
  logic btn_load = 0;
  logic btn_trans = 0;
  logic [7:0] data ;

  // Outputs
  logic bit_to_send;
  logic [8:0] data_prev;

  // Instantiate the module
  tx dut (
    .clk(clk),
    .btn_load(btn_load),
    .btn_trans(btn_trans),
    .data(data),
    .bit_to_send(bit_to_send),
    .data_prev(data_prev)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Test scenario
  initial begin
    // Start with idle state
    data = 8'b10101000 ; 
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_trans = 1;
    #5;
    btn_trans = 0;

    // Wait for transmission to complete
    #100;

    // Observe outputs
    $display("Data sent: %b", data_prev);
    $display("Last bit sent: %b", bit_to_send);

    // End simulation
    #10;
    data = 8'b11111100 ; 
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_trans = 1;
    #5;
    btn_trans = 0;

    // Wait for transmission to complete
    #100;

    // Observe outputs
    $display("Data sent: %b", data_prev);
    $display("Last bit sent: %b", bit_to_send);

    // End simulation
    #10;
    data = 8'b11111100 ; 
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_trans = 1;
    #5;
    btn_trans = 0;

    // Wait for transmission to complete
    #100;

    // Observe outputs
    $display("Data sent: %b", data_prev);
    $display("Last bit sent: %b", bit_to_send);

    // End simulation
    #10;
    data = 8'b11111111 ; 
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_trans = 1;
    #5;
    btn_trans = 0;

    // Wait for transmission to complete
    #100;

    // Observe outputs
    $display("Data sent: %b", data_prev);
    $display("Last bit sent: %b", bit_to_send);

    // End simulation
    #10;
    data = 8'b10011100 ; 
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_trans = 1;
    #5;
    btn_trans = 0;

    // Wait for transmission to complete
    #100;

    // Observe outputs
    $display("Data sent: %b", data_prev);
    $display("Last bit sent: %b", bit_to_send);

    // End simulation
    #10;
    data = 8'b01101100 ; 
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_trans = 1;
    #5;
    btn_trans = 0;

    // Wait for transmission to complete
    #100;

    // Observe outputs
    $display("Data sent: %b", data_prev);
    $display("Last bit sent: %b", bit_to_send);

    // End simulation
    #10;
    data = 8'b00000000 ; 
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_trans = 1;
    #5;
    btn_trans = 0;

    // Wait for transmission to complete
    #100;

    // Observe outputs
    $display("Data sent: %b", data_prev);
    $display("Last bit sent: %b", bit_to_send);

    // End simulation
    #10;data = 8'b01010101 ; 
    btn_load = 1;
    #10; // Wait a bit
    btn_load = 0;

    // Wait for a few clock cycles
    #20;

    // Trigger transmission
    btn_trans = 1;
    #5;
    btn_trans = 0;

    // Wait for transmission to complete
    #100;

    // Observe outputs
    $display("Data sent: %b", data_prev);
    $display("Last bit sent: %b", bit_to_send);

    // End simulation
    #10;
    
    $finish;
  end

endmodule*/


