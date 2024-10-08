`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2024 13:14:49
// Design Name: 
// Module Name: display
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


module display(
    input logic clk ,
    input logic active ,
    input logic [1:0] index ,
    input logic [7:0] data_to_show ,
    output logic [3:0] anodes ,
    output logic [6:0] seg 
    );
    parameter r = 7'b0111001 ;
    parameter t = 7'b1110000 ;
    logic tOrR ;
    logic [1:0] anodeIndex ;
    logic[19:0] refresh ;
    logic[7:0] led ;
    always @(posedge clk)
    begin
        if (active)
            tOrR <= 1 ;
        else 
            tOrR <= 0 ;
    end
    always @(posedge clk)
    begin
    refresh <= refresh + 1 ;
    end
    
    assign anodeIndex = refresh[19:18] ;
    
    
    always @(posedge clk)
    begin 
        case (anodeIndex)
            0 : begin anodes = 4'b1110 ; led <= {1'b0,data_to_show[3:0]} ; end
            1 : begin anodes = 4'b1101 ; led <= {1'b0,data_to_show[7:4]} ; end
            2 : begin anodes = 4'b1011 ; led <= index ; end
            3 : begin anodes = 4'b0111 ; if (tOrR) led <= 5'b11111 ; else led <= 5'b10000 ; end
        endcase 
    end
    
    always @(*)
        case (led)
        5'b00000: seg = 7'b0000001 ;
        5'b00001: seg = 7'b1001111 ;
        5'b00010: seg = 7'b0010010 ;
        5'b00011: seg = 7'b0000110 ;
        5'b00100: seg = 7'b1001100 ;
        5'b00101: seg = 7'b0100100 ;
        5'b00110: seg = 7'b0100000 ;
        5'b00111: seg = 7'b0001111 ;
        5'b01000: seg = 7'b0000000 ;
        5'b01001: seg = 7'b0000100 ;
        5'b01010: seg = 7'b0001000 ;
        5'b01011: seg = 7'b0000000 ;
        5'b01100: seg = 7'b0110001 ;
        5'b01101: seg = 7'b0000001 ;
        5'b01110: seg = 7'b0110000 ;
        5'b01111: seg = 7'b0111000 ;
        5'b10000: seg = r ;
        5'b11111: seg = t ;
        default : seg = 7'b1111110; 
        endcase 
endmodule
