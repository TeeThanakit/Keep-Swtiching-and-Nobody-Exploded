`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2023 10:34:09 AM
// Design Name: 
// Module Name: difficulty_game_mode
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
module difficulty_game_mode(
  input btnL,
  input btnR,
  input clock,  // Add clock input
  input [15:0] sw,
  output reg [1:0] current_mode
);  

  initial current_mode = 2'b01;
  always @(posedge clock) begin
    if (btnL) begin
      case (current_mode)
        2'b01: current_mode <= 2'b11;
        2'b10: current_mode <= 2'b01;
        2'b11: current_mode <= 2'b10;
      endcase
    end else if (btnR) begin
      case (current_mode)
        2'b01: current_mode <= 2'b10;
        2'b10: current_mode <= 2'b11;
        2'b11: current_mode <= 2'b01;
      endcase
    end
  end
endmodule