`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2024 02:07:40
// Design Name: 
// Module Name: four_uart_v2
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


module four_uart_v2(
    input logic clk ,
    input logic btn_r ,
    input logic active ,
    input logic btn_l ,
    input logic btn_load ,
    input logic btn_trans ,
    input logic[7:0] data , 
    output logic [3:0] anodes ,
    output logic [6:0] seg 
    );
    logic[1:0] index ;
    reg [31:0] txbuf ;
    reg [31:0] rxbuf ;
    logic [7:0] to_show ;
    logic [7:0] data_to_save1 ;
    logic [7:0] data_to_save2 ;
    logic saved ;
    logic send ;
    logic loaded ;
    logic right , left ;
    justOne j1(clk , btn_r , right) ;
    justOne j2(clk , btn_l , left) ;
    always @(posedge clk)
    begin
        if (right)
        begin
            index <= index + 1 ;
        end    
        if (left)
        begin 
            index <= index - 1 ;
        end 
    end
    justOne j(clk , btn_load , loaded) ;
    always @(posedge clk)
        begin
            if (loaded)
            begin 
                    txbuf[31:24] <= txbuf[23:16] ;
                    txbuf[23:16] <= txbuf[15:8] ;
                    txbuf[15:8] <= txbuf[7:0] ;
                    txbuf[7:0] <= data ;
            end
        end
     tx t(clk , btn_load , btn_trans , txbuf[31:24] , send , data_to_save1) ;
     
     four_rx_v2 r(clk , send , data_to_save2 , saved) ;
     always @(posedge clk)
    begin
         if (saved)
         begin
             rxbuf[7:0] <= rxbuf[15:8] ;
             rxbuf[15:8] <= rxbuf[23:16] ;
             rxbuf[23:16] <= rxbuf[31:24] ;
             rxbuf[31:24] <= data_to_save2 ;     
         end
    end
    // 0 - 0 7 ; 1 - 8 15 ; 2 - 16 23 ; 3 - 24 31 
    always @(posedge clk)
    begin
        if (active)
        begin 
            case (index)
                0 : to_show <= txbuf[7 : 0] ;
                1 : to_show <= txbuf[15 : 8] ;
                2 : to_show <= txbuf[23 : 16] ;
                3 : to_show <= txbuf[31 : 24] ;
            endcase   
        end
        else 
        begin
            case (index)
                0 : to_show <= rxbuf[7 : 0] ;
                1 : to_show <= rxbuf[15 : 8] ;
                2 : to_show <= rxbuf[23 : 16] ;
                3 : to_show <= rxbuf[31 : 24] ;
            endcase   
        end
    end    
    display disp(clk , active , index , to_show , anodes , seg) ;
endmodule
