`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 06:48:47 PM
// Design Name: 
// Module Name: game
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


module game(
    input clock,
    input [15:0] sw,
    input is_timeout,
    output reg [15:0] led
);
 always @ (is_timeout) begin
        if(is_timeout == 0) begin
            led[15] = 1'b0;
          led[14] = 1'b0;
          led[13] = 1'b0;
          led[12] = 1'b0;
          led[11] = 1'b1;
          led[10] = 1'b1;
          led[9] = 1'b0;
          led[8] = 1'b0;
          led[7] = 1'b1;
          led[6] = 1'b1;
          led[5] = 1'b1;
          led[4] = 1'b1;
          led[3] = 1'b1;
          led[2] = 1'b1;
          led[1] = 1'b1;
        end
 end
endmodule
