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
  output reg [15:0] led,
  output reg [1:0] current_mode
//  output out1
);  

  // setting buttons before the game
  wire pressedC, pressedL, pressedR;
//  tff_module tffl (btnL, clock, pressedL);
//  tff_module tffr (btnR, clock, pressedR);
    
  debouncedbutton dbbl (btnL, clock, pressedL);
  debouncedbutton dbbr (btnR, clock, pressedR);
  
  initial current_mode = 2'b01;
  always @ (posedge clock)
    if(pressedL) begin
        if (current_mode == 2'b01) begin //mode 1
            current_mode <= 2'b11; //mode 1 to mode 3    
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
        else if (current_mode == 2'b10) begin
            current_mode <= 2'b01; 
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
        else if (current_mode == 2'b11) begin
            current_mode <= 2'b10; 
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
    end
    else if(pressedR) begin
        if (current_mode == 2'b01) begin
            current_mode <= 2'b10;
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
        else if (current_mode == 2'b10) begin
            current_mode <= 2'b11; 
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
        else if (current_mode == 2'b11) begin
            current_mode <= 2'b01; 
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
    end
    
endmodule