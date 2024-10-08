`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2024 15:31:27
// Design Name: 
// Module Name: uart
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


module uart(
    input logic clk ,
    input logic rx ,
    input logic btn_load ,
    input logic btn_trans ,
    input logic[7:0] data , 
    output logic tx ,
    output logic par ,
    output logic [8:0] data_new
    );
    logic [8:0] cur ;
    logic bit_to_send ;
    tx t(clk , btn_load , btn_trans , data , bit_to_send , cur) ;
    assign par = cur[8] ;
    rx r(clk , bit_to_send , data_new) ;
endmodule
