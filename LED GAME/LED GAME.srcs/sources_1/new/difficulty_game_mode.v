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
module tff_module (
  input T,       // T input
  input clk,     // Clock input
  output reg Q   // Output
);
  always @(posedge clk) begin
    Q <= T ? ~Q : Q;  // Toggle the output based on T input
  end
endmodule

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
  reg pressedC, pressedL, pressedR;
  reg is_selected;  // Declare is_start signal

  tff_module tffc (is_selected, clock, pressedC);
  tff_module tffu (btnL, clock, pressedL);
  tff_module tffd (btnR, clock, pressedR);

  //initial begin
    //current_mode = 2'b01;
    //$display("Initialized value: %d", current_mode);
  //end

  always @(posedge clock) 
    if (pressedL) 
    begin
//      if (current_mode == 2'b01)
//      begin
//        current_mode = 2'b11;
//      end
//      else
      //begin
        current_mode = current_mode - 2'b01;
      //end
    end
    else if (pressedR)
    begin
        if(current_mode == 2'b11)
            current_mode = 2'b01;
        else
            current_mode = current_mode + 2'b01;
    end
  
  // Activate LEDs based on current_mode
  always @(current_mode)
  begin
    case (current_mode)
      2'b01: 
      begin
      led[15] = 1'b1;
      led[14] = 1'b1;
      led[13] = 1'b1;
      led[12] = 1'b1;
      led[11] = 1'b1;
      end  
       //LD11 on
      2'b10: 
      begin
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
      end
      2'b11:
      begin
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
      //default: led = 16'h0000; // All LEDs off for unknown mode
    endcase
  end
  
  
endmodule