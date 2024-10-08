`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2024 20:03:40
// Design Name: 
// Module Name: dd
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


module dd(
    input clock ,
    input logic load ,
    output logic[3:0] i 
    );
    logic [3:0] counter ;
    wire new_clk ;
    debounce d(load , clock , new_clk) ;
    always @(posedge new_clk)
    begin
        counter <= counter + 1 ;
        i <= counter ; 
    end
endmodule
