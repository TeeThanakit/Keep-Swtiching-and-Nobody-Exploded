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
    
    always @* begin
      if(is_timeout==1'b1)  begin
      case (current_mode)
        2'b01: begin
          led=16'b1111100000000000;
        end
        2'b10: begin
          led=16'b1111111111000000; 
        end
        2'b11: begin
          led=16'b1111111111111111;
        end
      endcase 
    end
    else if(is_timeout==1'b0) begin
      led=16'b1010101010101010;
    end
    end 
endmodule
