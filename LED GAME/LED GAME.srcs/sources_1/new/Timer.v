`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2023 10:57:46 AM
// Design Name: 
// Module Name: Timer
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


module Timer(
    input is_start,
    input btnU,btnD,
    input clock,
    output is_timeout,
    output [6:0] seg,
    output reg [3:0] AN
    );
    reg elasped;
    reg [27:0] state;
    
    always @ (posedge clock) // 100,000,000 posedge = 1 second
    if (state == 100000000)
        state <= 0;
    else 
        state <= state +1;
    always @(state)
        if (state == 100000000)
            elasped = 1;
        else 
            elasped = 0;
    assign clk_out = elasped;
    always @(state)
    begin
        case(state[15:16]) // each AN display a quarter in 1 second.
        2'b00 : AN <= 4'b0111;
        2'b01 : AN <= 4'b1011;
        2'b10 : AN <= 4'b1101;
        2'b11 : AN <= 4'b1110;
        endcase
    end
endmodule

module divide (
    input is_start,
    input btnU,btnD,
    input clock,
    output is_timeout,
    output [6:0] seg,
    output reg [3:0] AN
    );
    reg elasped;
    reg [27:0] state;
    
    always @ (posedge clock) // 100,000,000 posedge = 1 second
    if (state == 100000000)
        state <= 0;
    else 
        state <= state +1;
    always @(state)
        if (state == 100000000)
            elasped = 1;
        else 
            elasped = 0;
    assign clk_out = elasped;
    always @(state)
    begin
        case(state[15:16]) // each AN display a quarter in 1 second.
        2'b00 : AN <= 4'b0111;
        2'b01 : AN <= 4'b1011;
        2'b10 : AN <= 4'b1101;
        2'b11 : AN <= 4'b1110;
        endcase
    end
endmodule
