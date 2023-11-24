`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2023 10:36:33 AM
// Design Name: 
// Module Name: random
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


module random(
    input clk,
    input rst,
    input start_generation, // Signal to trigger random number generation
    output reg [3:0] random_numbers [0:9] // Array of 10 random numbers
);

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) 
        begin
            for (i = 0; i < 10; i= i+1) 
            begin
                random_numbers[i] <= 4'b0000; // Reset the random numbers to 0
            end
        end 
        else 
        begin
            if (start_generation) 
            begin
                for (i = 0; i < 10; i = i+1) 
                begin
                    random_numbers[i] <= $urandom_range(16); // Generate a random number between 0 and 15 for each element in the array
                end
            end
        end
    end

endmodule

