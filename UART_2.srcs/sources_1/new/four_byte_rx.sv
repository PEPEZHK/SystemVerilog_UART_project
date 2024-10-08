`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2024 01:17:37
// Design Name: 
// Module Name: four_byte_rx
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
module four_byte_rx(
    input logic clk, 
    input logic act ,
    input logic trans ,
    input logic bit_to_put ,
    output logic [7:0] data ,
    output logic [31:0] rxbuf
    );
    parameter BAUD_RATE = 115200;
    parameter CYCLE_PER_BIT = 870;
    parameter idle = 2'b00;
    parameter start = 2'b01;
    parameter put = 2'b10;
    parameter stop = 2'b11;
    integer numOf1;
    logic done ;
    logic [4:0] index ;
    logic [4:0] limit ;
    logic [1:0] next_step ;
    logic [31:0] data_prev = 0 ; // if 255 > rxbuf <= data_prev ;
    logic rx_buffer;
    logic rx;
    logic [15:0] counter = 0;
    always @(posedge clk)
    begin
        if (act) 
        begin
            limit <= 31 ;
        end
        else 
        begin
            limit <= 7 ;
        end
    end
    always @(posedge clk) begin
        rx_buffer <= bit_to_put;
        rx <= rx_buffer;
    end
    
    always @(posedge clk) begin
        case (next_step)
            idle: begin
                if (rx == 1'b0) begin
                    counter <= 0;
                    index <= 0;
                    next_step <= start;
                end else begin
                    next_step <= idle;
                end
                done <= 0 ;
            end
            start: begin
                if (counter == (CYCLE_PER_BIT - 1) / 2) begin
                    if (rx == 1'b0) begin
                        counter <= 0;
                        next_step <= put;
                    end else begin
                        next_step <= idle;
                    end
                end else begin
                    counter <= counter + 1;
                    next_step <= start;
                end
            end
            put: begin
                if (counter < CYCLE_PER_BIT - 1) begin
                    counter <= counter + 1;
                    next_step <= put ;
                end else begin
                    counter <= 0;
                    if (index < limit + 1) begin
                        if (rx == 1'b1)
                           numOf1 <= numOf1 + 1 ;
                        data_prev[index] <= rx ;
                        index <= index + 1;
                        next_step <= put;
                    end else begin
                        index <= 0 ;
                        next_step <= stop ;
                        if (numOf1 % 2 == 0 && rx == 1) begin end
                        else if(numOf1 % 2 == 1 && rx == 0) begin end
                        else
                        begin 
                            data_prev <= 0 ;
                        end
                        numOf1 <= 0 ;
                    end
                end
            end
            stop: begin
                if (counter < CYCLE_PER_BIT - 1) begin
                    counter <= counter + 1;
                    next_step <= stop ;
                end else begin
                    counter <= 0;
                    next_step <= idle;
                    done <= 1 ;
                end
            end
            default: next_step <= idle;
        endcase
        if (act && trans)
                    begin 
                        data <= data_prev ;
                        rxbuf <= data_prev ;
                    end
                    else if (~act && done) 
                    begin
                        data <= rxbuf[31:24] ;
                        rxbuf[31:24] <= rxbuf[23:16] ;
                        rxbuf[23:16] <= rxbuf[15:8] ;
                        rxbuf[15:8] <= rxbuf[7:0] ;
                        rxbuf[7:0] <= data_prev[7:0] ; 
                    end
    end
endmodule

