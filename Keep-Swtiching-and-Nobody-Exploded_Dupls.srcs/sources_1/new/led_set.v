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
    input btnC,
    input clock,
    input [1:0] current_mode,
    input is_timeout,
    input [15:0] sw,
    input [27:0] state,
    output reg [15:0] led,
    output reg win,
    output reg restart
    );
    reg [15:0] Easy [4:0];
    reg [15:0] Med [9:0];
    reg [15:0] Hard [15:0];
    reg [15:0] Ecombi [15:0];
    reg [15:0] zero;
    reg i;
    
    reg [4:0] seed;
    reg [2:0] Random;
    reg [2:0] ERandom [4:0][4:0];
   
    
    initial begin
    Easy[0] = 16'b1011010110101001;
    Easy[1] = 16'b1111000011110000;
    Easy[2] = 16'b0101010101010101;
    Easy[3] = 16'b1011101010100110;
    Easy[4] = 16'b1100110011001100;
    
    Med[0] = 16'b0101000111111001;
    Med[1] = 16'b1111000011110000;
    Med[2] = 16'b0100110101010101;
    Med[3] = 16'b1010101001101010;
    Med[4] = 16'b1100110011001100;
    Med[5] = 16'b0011110000100100;
    Med[6] = 16'b0101101010110101;
    Med[7] = 16'b1110001110001110;
    Med[8] = 16'b0010111110101000;
    Med[9] = 16'b1000100010001000;
    
    Hard[0]  = 16'b1000100110100111;
    Hard[1]  = 16'b1111000011110000;
    Hard[2]  = 16'b0101010101010101;
    Hard[3]  = 16'b1010101010101010;
    Hard[4]  = 16'b1100110011001100;
    Hard[5]  = 16'b0011110000111100;
    Hard[6]  = 16'b0101101010110101;
    Hard[7]  = 16'b1110001110001110;
    Hard[8]  = 16'b0011001100110011;
    Hard[9]  = 16'b1000100010001000;
    Hard[10] = 16'b0110011001100110;
    Hard[11] = 16'b1011011101101101;
    Hard[12] = 16'b0010101010101011;
    Hard[13] = 16'b1101111111000100;
    Hard[14] = 16'b0000100010101010;
    Hard[15] = 16'b1111111111001111;
    
    ERandom[0][0] = 0;
    ERandom[0][1] = 1;
    ERandom[0][2] = 2;
    ERandom[0][3] = 3;
    ERandom[0][4] = 4;

    ERandom[1][0] = 1;
    ERandom[1][1] = 2;
    ERandom[1][2] = 3;
    ERandom[1][3] = 4;
    ERandom[1][4] = 0;

    ERandom[2][0] = 2;
    ERandom[2][1] = 3;
    ERandom[2][2] = 4;
    ERandom[2][3] = 0;
    ERandom[2][4] = 1;

    ERandom[3][0] = 3;
    ERandom[3][1] = 4;
    ERandom[3][2] = 0;
    ERandom[3][3] = 1;
    ERandom[3][4] = 2;

    ERandom[4][0] = 4;
    ERandom[4][1] = 0;
    ERandom[4][2] = 1;
    ERandom[4][3] = 2;
    ERandom[4][4] = 3;
    
    seed = 5'd0;  // Initial seed value
    Random = seed;
    zero = 16'b0000000000000000;
    win = 0;
    end
    
    always @(posedge clock) begin
    if(!win) begin
        restart=0;
      if(is_timeout==1'b1)  begin
      Random <= $urandom % 5;
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
     case (current_mode)
        2'b01: begin
          Ecombi[15] = (sw[15] == 1) ? Easy[ERandom[Random][0]] : zero;
          Ecombi[14] = (sw[14] == 1) ? Easy[ERandom[Random][1]] : zero;
          Ecombi[13] = (sw[13] == 1) ? Easy[ERandom[Random][2]] : zero;
          Ecombi[12] = (sw[12] == 1) ? Easy[ERandom[Random][3]] : zero;
          Ecombi[11] = (sw[11] == 1) ? Easy[ERandom[Random][4]] : zero;

          led = Ecombi[15] ^ Ecombi[14] ^ Ecombi[13] ^ Ecombi[12] ^ Ecombi[11];
          
          if(led==16'b1111111111111111) win=1;
          
        end
        2'b10: begin
          Ecombi[15] = (sw[15] == 1) ? Med[0] : zero;
          Ecombi[14] = (sw[14] == 1) ? Med[1] : zero;
          Ecombi[13] = (sw[13] == 1) ? Med[2] : zero;
          Ecombi[12] = (sw[12] == 1) ? Med[3] : zero;
          Ecombi[11] = (sw[11] == 1) ? Med[4] : zero;
          Ecombi[10] = (sw[10] == 1) ? Med[5] : zero;
          Ecombi[9] = (sw[9] == 1) ? Med[6] : zero;
          Ecombi[8] = (sw[8] == 1) ? Med[7] : zero;
          Ecombi[7] = (sw[7] == 1) ? Med[8] : zero;
          Ecombi[6] = (sw[6] == 1) ? Med[9] : zero;
          
          led = Ecombi[15] ^ Ecombi[14] ^ Ecombi[13] ^ Ecombi[12] ^ Ecombi[11] ^ Ecombi[10] ^ Ecombi[9] ^ Ecombi[8] ^ Ecombi[7] ^ Ecombi[6];
        
          if(led==16'b1111111111111111) win=1;
        end
        2'b11: begin
          Ecombi[15] = (sw[15] == 1) ? Hard[0] : zero;
          Ecombi[14] = (sw[14] == 1) ? Hard[1] : zero;
          Ecombi[13] = (sw[13] == 1) ? Hard[2] : zero;
          Ecombi[12] = (sw[12] == 1) ? Hard[3] : zero;
          Ecombi[11] = (sw[11] == 1) ? Hard[4] : zero;
          Ecombi[10] = (sw[10] == 1) ? Hard[5] : zero;
          Ecombi[9] = (sw[9] == 1) ? Hard[6] : zero;
          Ecombi[8] = (sw[8] == 1) ? Hard[7] : zero;
          Ecombi[7] = (sw[7] == 1) ? Hard[8] : zero;
          Ecombi[6] = (sw[6] == 1) ? Hard[9] : zero;
          Ecombi[5] = (sw[5] == 1) ? Hard[10] : zero;
          Ecombi[4] = (sw[4] == 1) ? Hard[11] : zero;
          Ecombi[3] = (sw[3] == 1) ? Hard[12] : zero;
          Ecombi[2] = (sw[2] == 1) ? Hard[13] : zero;
          Ecombi[1] = (sw[1] == 1) ? Hard[14] : zero;
          Ecombi[0] = (sw[0] == 1) ? Hard[15] : zero;
          
          led = Ecombi[15] ^ Ecombi[14] ^ Ecombi[13] ^ Ecombi[12] ^ Ecombi[11] ^ Ecombi[10] ^ Ecombi[9] ^ Ecombi[8] ^ Ecombi[7] ^ Ecombi[6] ^ Ecombi[5] ^ Ecombi[4] ^ Ecombi[3] ^ Ecombi[2] ^ Ecombi[1] ^ Ecombi[0];
        
            if(led==16'b1111111111111111) win=1;
        end
      endcase 
    end
    end 
    else if(btnC) begin
                win=0;
                restart=1;
                Random <= seed;
            end 
        else if(win==1 && state == 100000000) begin 
            case(led)
            16'b1111111111111111 : begin
            led = 16'b0000000000000000;
            end
            16'b0000000000000000 : begin
            led = 16'b1111111111111111;
            end
            endcase
            end
        end
   
endmodule