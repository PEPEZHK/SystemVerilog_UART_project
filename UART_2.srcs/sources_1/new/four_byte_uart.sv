`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2024 01:17:37
// Design Name: 
// Module Name: four_byte_uart
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
//////////////////////////////////////////////////////////////////////////////////
module debounce(input logic clk , btn , output logic res) ;
reg out = 0 ;
always_ff @(posedge clk)
begin
    if (~out && btn)
        res <= 1 ;
    else
        res <= 0 ;
    out <= btn ;
end
endmodule

module four_byte_uart(
    input logic clk ,
    input logic cont ,
    input logic active ,
    input logic btn_load ,
    input logic btn_trans ,
    input logic btn_right ,
    input logic btn_left ,
    input logic[7:0] data , 
    input logic take ,
    output logic send ,
    output logic [7:0] data_tx , 
    output logic [7:0] data_rx , 
    output logic [3:0] anodes ,
    output logic [6:0] seg 
    );
    logic [31:0] txbuf ;
    logic [31:0] rxbuf ;
    logic [7:0] data_to_show ;
    logic [1:0] i ;
    logic inc_flag , dec_flag ;
    logic load , transmit , left , right , all;
    debounce d1(clk , btn_load , load) ;
    debounce d2(clk , btn_trans , transmit) ;
    debounce d3(clk , btn_right , right) ;
    debounce d4(clk , btn_left , left) ;
    //debounce d5(clk , cont , all) ;
    always_ff @(posedge clk)
    begin
        if (right)
            i <= i + 1 ;
        else if (left)
            i <= i - 1 ;
    end
    logic to_send ;
    four_byte_tx t(clk , cont , data , load , transmit , to_send , data_tx , txbuf) ;

    four_byte_rx r(clk , cont , transmit , to_send , data_rx , rxbuf) ;
    
    always @(posedge clk)
    begin
        if (active)
        begin
            case (i)
                0 : data_to_show <= txbuf[7:0] ;
                1 : data_to_show <= txbuf[15:8] ;
                2 : data_to_show <= txbuf[23:16] ;
                3 : data_to_show <= txbuf[31:24] ;
            endcase    
        end
        else 
        begin
            case (i)
                0 : data_to_show <= rxbuf[7:0] ;
                1 : data_to_show <= rxbuf[15:8] ;
                2 : data_to_show <= rxbuf[23:16] ;
                3 : data_to_show <= rxbuf[31:24] ;
            endcase    
        end
    end
    display disp(clk , active , i , data_to_show , anodes , seg) ;
endmodule
