`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2024 13:45:05
// Design Name: 
// Module Name: tx
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

module slowClock(input logic clk, output logic led);
    logic clk_1sec ; 
    logic [27:0] counter;
    
    always @(posedge clk) 
    begin
            counter <= counter + 1;
            if (counter == 75_000_000) 
            begin
                counter <= 0;
                clk_1sec <= ~clk_1sec;
            end
    end
assign led = clk_1sec ;
endmodule
module setClock(input logic clk , output logic new_clk);
logic temp_clk ;
parameter BAUD_RATE = 115200 ;
parameter CYCLE_PER_BIT = 100000000/BAUD_RATE ;
logic [15:0] c = 0;
always_ff @(posedge clk) 
    begin
    c <= c + 1;
    if (c == CYCLE_PER_BIT - 1) 
        begin
        temp_clk <= ~temp_clk; 
        c <= 0;  
        end
    end
assign new_clk = temp_clk ;
endmodule


module tx(
    input logic clk ,
    input logic btn_load ,
    input logic btn_trans ,
    input logic [7:0]data , 
    output logic bit_to_send ,
    output logic [8:0] data_prev 
    );
    logic transmit ;
    logic [8:0]data_pr ;
    logic [15:0] counter ;
    logic [3:0] index ;
    logic [1:0]next_step ; 
    parameter BAUD_RATE = 115200 ;
    parameter CYCLE_PER_BIT = 870 ;
    parameter idle = 2'b01 ;
    parameter start = 2'b00 ;
    parameter send = 2'b10 ;
    parameter stop = 2'b11 ;
    beforeTransmission beforee(new_clk , btn_load ,btn_trans , data , data_pr , transmit) ; 
    always @(posedge clk)
    begin
    case (next_step) 
            idle : begin
                    if (transmit)
                    begin
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
                        bit_to_send <= data_pr[index] ;
                        if (index < 8) 
                        begin  
                            data_prev[index] <= data_pr[index] ;
                            index <= index + 1 ;
                            next_step <= send ;
                        end
                        else 
                        begin
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
                            counter <= 0 ;
                            next_step <= idle ;
                       end   
                     end
            default : next_step <= idle ;    
    endcase   
    end
endmodule

