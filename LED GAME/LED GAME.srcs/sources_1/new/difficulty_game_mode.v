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
//module tff_module (
//  input T,       // T input
//  input clk,     // Clock input
//  output reg Q   // Output
//);
//  always @(posedge clk) begin
//    Q <= T ? ~Q : Q;  // Toggle the output based on T input
//  end
//endmodule

module difficulty_game_mode(
  input btnC,
  input btnL,
  input btnR,
  input clock,  // Add clock input
  input [15:0] sw,
  output reg [15:0] led,
  output reg [1:0] current_mode
);  
  wire pressedL, pressedR;
    
  debouncedbutton dbbl (btnL, clock, pressedL);
  debouncedbutton dbbr (btnR, clock, pressedR);
  
  initial current_mode = 2'b01;
  always @ (posedge clock) begin
    if (pressedL) begin
      case (current_mode)
        2'b01: current_mode <= 2'b11;
        2'b10: current_mode <= 2'b01;
        2'b11: current_mode <= 2'b10;
      endcase
    end else if (pressedR) begin
      case (current_mode)
        2'b01: current_mode <= 2'b10;
        2'b10: current_mode <= 2'b11;
        2'b11: current_mode <= 2'b01;
      endcase
    end
  end
endmodule