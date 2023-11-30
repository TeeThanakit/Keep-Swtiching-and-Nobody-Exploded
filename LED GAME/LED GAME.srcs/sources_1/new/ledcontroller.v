`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 07:15:12 PM
// Design Name: 
// Module Name: ledcontroller
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
module ledcontroller( 
    input clock,
    input [1:0] current_mode,
    input is_timeout,
    output reg [15:0] led
    );
    
    always @ (current_mode) begin
      case (current_mode)
        2'b01: begin
          led[15] = 1'b1;
            led[14] = 1'b1;
            led[13] = 1'b1;
            led[12] = 1'b1;
            led[11] = 1'b1;
            led[10] = 1'b0;
            led[9] = 1'b0;
            led[8] = 1'b0;
            led[7] = 1'b0;
            led[6] = 1'b0;
            led[5] = 1'b0;
            led[4] = 1'b0;
            led[3] = 1'b0;
            led[2] = 1'b0;
            led[1] = 1'b0;
        end
        2'b10: begin
          led[15] = 1'b1;
            led[14] = 1'b1;
            led[13] = 1'b1;
            led[12] = 1'b1;
            led[11] = 1'b1;
            led[10] = 1'b1;
            led[9] = 1'b1;
            led[8] = 1'b1;
            led[7] = 1'b1;
            led[6] = 1'b1;
            led[5] = 1'b0;
            led[4] = 1'b0;
            led[3] = 1'b0;
            led[2] = 1'b0;
            led[1] = 1'b0;    
        end
        2'b11: begin
           led[15] = 1'b1;
            led[14] = 1'b1;
            led[13] = 1'b1;
            led[12] = 1'b1;
            led[11] = 1'b1;
            led[10] = 1'b1;
            led[9] = 1'b1;
            led[8] = 1'b1;
            led[7] = 1'b1;
            led[6] = 1'b1;
            led[5] = 1'b1;
            led[4] = 1'b1;
            led[3] = 1'b1;
            led[2] = 1'b1;
            led[1] = 1'b1;
        end
      endcase 
    end 
endmodule
