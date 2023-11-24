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
    input [15:0] sw,
    input [4:0] button,
    input btnC,btnU,btnL,btnR,btnD,
    output [15:0] led,
    output [6:0] seg,
    output [3:0] an
    );
    wire random_led;
    random(btnC,btnU,btnL,btnR,btnD,random_led);
    
    
endmodule
