`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 11/24/2023 10:00:29 AM
// Design Name: 
// Module Name: top_module
// Project Name: led game
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


module top_module(
    input clock,
    input [15:0] sw,
    input btnC,btnU,btnL,btnR,btnD,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an
    );
    wire [1:0] current_mode;
    wire is_timeout;
    wire pressedL, pressedR;
    
    debouncedbutton DBBL (btnL, clock, pressedL);
    debouncedbutton DBBR (btnR, clock, pressedR);
  
    Timer T1(btnC,btnU,btnD,clock,is_timeout,seg,an);
    difficulty_game_mode G1(btnC, pressedL, pressedR,clock,sw,current_mode);
    ledcontroller LC1(clock, current_mode, is_timeout, led);
endmodule
