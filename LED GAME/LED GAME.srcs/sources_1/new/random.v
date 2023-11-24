module RandomSwitchLEDController (
    input wire clk,
    input wire rst,
    output reg [15:0] leds,
    output reg [15:0] switches
);

    // Internal signals
    reg[15:0] random_switches;
    reg [15:0] obstruction_switches;

    // Counter for LED activation
    reg [3:0] led_count;

    // Parameter for the number of LEDs and switches
    parameter NUM_LEDS = 16;
    parameter NUM_SWITCHES = 16;

    // Random number generator module
    RandomNumberGenerator #(
        .NUM_BITS(4) // Number of bits needed to represent NUM_SWITCHES
    ) rng (
        .clk(clk),
        .rst(rst),
        .start_generation(1),
        .random_numbers(random_switches)
    );

    // LED control logic
    always @(posedge clk or posedge rst)
    begin
        if (rst) 
        begin
            leds <= 16'b0000_0000_0000_0000;
            switches <= 16'b0000_0000_0000_0000;
            led_count <= 4'b0000;
            obstruction_switches <= 16'b0000_0000_0000_0000;
        end 
        else 
        begin
            if (led_count == NUM_LEDS) 
            begin
                // All LEDs are lit, reset LED count and obstruction switches
                led_count <= 4'b0000;
                obstruction_switches <= 16'b0000_0000_0000_0000;
            end 
            else 
            begin
                // Increment LED count and set corresponding LED
                led_count <= led_count + 1;
                leds[led_count] <= 1'b1;
                obstruction_switches[random_switches[led_count]] <= 1'b1;
            end
            // Output the selected switches
            switches <= random_switches & ~obstruction_switches;
        end
    end

endmodule
