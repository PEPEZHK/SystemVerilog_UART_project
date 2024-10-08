`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2024 01:17:37
// Design Name: 
// Module Name: four_byte_tx
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
module four_byte_tx(
    input logic clk , 
    input logic act ,
    input logic[7:0] data ,
    input logic btn_load ,
    input logic btn_trans ,
    output logic bit_to_send ,
    output logic [7:0] data_prev ,
    output logic [31:0] txbuf
    );
    logic[4:0] index ;
    logic [4:0] limit ;
    logic[15:0] counter ;
    logic[3:0] next_step ;
    logic [31:0] data_to_send = 0 ;
    logic [7:0] data_to_show = 0 ;
    logic loaded ;
    logic done ;
    integer numOfOnes ;
    parameter BAUD_RATE = 115200 ;
    parameter CYCLE_PER_BIT = 870 ;
    parameter idle = 2'b01 ;
    parameter start = 2'b00 ;
    parameter send = 2'b10 ;
    parameter stop = 2'b11 ; 
    always @(posedge clk)
    begin
        if (act)
            limit <= 31 ;
        else 
            limit <= 7 ;
    end
    always @(posedge clk)
        begin
            if (btn_trans && ~act)
            begin
                data_to_send <= txbuf[31:24] ;
                txbuf[31:24] <= txbuf[23:16] ;
                txbuf[23:16] <= txbuf[15:8] ;
                txbuf[15:8] <= txbuf[7:0] ;
                txbuf[7:0] <= 0 ;
                data_prev <= 0 ;
            end
            else if (btn_trans && act)
            begin
                data_to_send <= txbuf ;
                txbuf <= 0 ;
                data_prev <= txbuf ;
            end
            if (btn_load && ~btn_trans)
            begin
                data_to_send <= txbuf[31:24] ;
                txbuf[31:24] <= txbuf[23:16] ;
                txbuf[23:16] <= txbuf[15:8] ;
                txbuf[15:8] <= txbuf[7:0] ;
                txbuf[7:0] <= data ;
                data_prev <= data ;
            end
        end
    always @(posedge clk)
    begin
    case (next_step) 
            idle : begin
                    if (btn_trans)
                    begin
                       done <= 0 ;
                       bit_to_send <= 0 ; 
                       next_step <= start ;
                    end
                    else 
                        begin
                        bit_to_send <= 1 ;
                        next_step <= idle ;
                        end
                   end
            start : begin 
                        if (counter == (CYCLE_PER_BIT-1)/2)
                        begin
                            counter <= 0  ;
                            next_step <= send ;
                        end
                        else 
                        begin
                            bit_to_send <= 0 ;
                            counter <= counter + 1 ;
                            next_step <= start ;
                        end
                    end
            send : begin
                   if (counter < CYCLE_PER_BIT-1)
                   begin 
                        counter <= counter + 1 ;
                   end
                   else
                   begin
                        counter <= 0 ;
                        if (index < limit + 1) 
                        begin  
                            bit_to_send <= data_to_send[index] ;
                            if (bit_to_send == 1)
                                numOfOnes <= numOfOnes + 1 ;
                            index <= index + 1 ;
                            next_step <= send ;
                        end
                        else 
                        begin
                            if (numOfOnes % 2 == 0)
                                bit_to_send <= 1 ;
                            else 
                                bit_to_send <= 0 ;
                            numOfOnes <= 0 ;
                            index <= 0 ;
                            next_step <= stop ;
                        end
                       end
                   end
              stop : begin
                     bit_to_send <= 1 ;
                     if (counter < CYCLE_PER_BIT-1)
                       begin 
                            counter <= counter + 1 ;
                            next_step <= stop ;
                       end
                       else
                       begin
                            done <= 1 ;
                            counter <= 0 ;
                            next_step <= idle ;
                       end   
                     end
            default : next_step <= idle ;    
    endcase 
    end
endmodule
