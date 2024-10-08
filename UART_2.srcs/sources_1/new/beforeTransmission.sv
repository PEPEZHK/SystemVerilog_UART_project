`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2024 13:50:22
// Design Name: 
// Module Name: beforeTransmission
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
module assignParity(input logic[7:0] data_in , output logic parity);
assign parity =  ~(data_in[0] ^ data_in[1]) ^  
             (data_in[2] ^ data_in[3]) ^ 
             (data_in[4] ^ data_in[5]) ^  
             (data_in[6] ^ data_in[7]);
endmodule

module beforeTransmission( 
    input logic clk ,
    input logic btn_load ,
    input logic btn_tr ,
    input logic[7:0] data, 
    output logic[8:0] data_cur,
    output logic transmit
    );
    logic parity_bit ;
    assignParity t(data , parity_bit) ;
always @(posedge clk)
begin
if (btn_load)
begin
data_cur <= {parity_bit , data} ;
$display("arrray : %b" , data_cur) ;
$display("arrray : %b" , data) ;
end
end
always @(posedge clk)
if (btn_tr)
transmit <= 1 ;
else 
transmit <= 0 ;
endmodule 
