`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2024 14:11:14
// Design Name: 
// Module Name: rx
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


module rx (
    input logic clk, 
    input logic bit_to_put,
    output logic [7:0] data
);

    parameter BAUD_RATE = 115200;
    parameter CYCLE_PER_BIT = 870;
    
    parameter idle = 2'b00;
    parameter start = 2'b01;
    parameter put = 2'b10;
    parameter stop = 2'b11;
    
    integer numOf1;
    reg [3:0] index ;
    reg [1:0] next_step ;
    reg [7:0] data_prev ;
    reg rx_buffer;
    reg rx;
    reg [15:0] counter = 0;

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
                    if (index < 8) begin
                        if (rx == 1'b1)
                           numOf1 <= numOf1 + 1 ;
                        data_prev[index] <= rx ;
                        index <= index + 1;
                        next_step <= put;
                    end else begin
                        index <= 0 ;
                        next_step <= stop ;
                        if (numOf1 % 2 == 0 && rx == 1)
                        begin 
                            data <= data_prev ;
                        end
                        else if(numOf1 % 2 == 1 && rx == 0)
                        begin 
                             data <= data_prev ;                        
                        end
                        else begin
                            data_prev = 0;
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
                end
            end
            default: next_step <= idle;
        endcase
    end
endmodule
