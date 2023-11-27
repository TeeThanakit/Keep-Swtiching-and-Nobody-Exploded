module tff_module (
  input T,       // T input
  input clk,     // Clock input
  output reg Q   // Output
);
  always @(posedge clk) begin
    Q <= T ? ~Q : Q;  // Toggle the output based on T input
  end
endmodule

module Timer(
    input is_start,
    input btnU,btnD,
    input clock,
    output reg is_timeout,
    output reg [6:0] seg,
    output reg [3:0] an
    );
    // for counting each second
    reg [27:0] state;
    reg elapsed;
    
    // count 1 second
    always @ (posedge clock) 
    if (state == 100000000)
        state <= 0;
    else 
        state <= state +1;
    always @(state)
        if (state == 100000000) 
            elapsed = 1;
        else 
            elapsed = 0;
            
    // switches between 7segment leds
    always @(state)
    begin
        case({state[16],state[15]})
        2'b00 : an <= 4'b1110;
        2'b01 : an <= 4'b1101;
        2'b10 : an <= 4'b1011;
        2'b11 : an <= 4'b0111;
        endcase
    end
    
    // an in LSB -> MSB
    reg [3:0] first;
    reg [3:0] second;
    reg [3:0] third;
    reg [3:0] fourth;
    // start from 30 seconds
    initial first = 0;
    initial second = 3;
    initial third = 0;
    initial fourth = 0;
    
    // setting buttons before the game
    wire pressedC,pressedU,pressedD;
    tff_module tffc (is_start,clock,pressedC);
    tff_module tffu (btnU,clock,pressedU);
    tff_module tffd (btnD,clock,pressedD);     
  
    always @(posedge elapsed)
    begin
    // Incrementing time
        if (pressedU && fourth == 0)
        begin
            if (first == 5)
            begin
                if (second == 9)
                begin
                    third = (third == 9) ? 0 : third + 1;
                    second = 0;
                    first = 0;
                end
                else 
                begin
                    second = second + 1;
                    first = 0;
                end
            end
            else 
                first = first + 5;
        end
        // Decrementing time
        else if (pressedD)
        begin
            if (first == 0)
            begin
                if (second == 0 && third != 0)
                begin
                    third = third - 1;
                    second = 9;
                    first = 5;
                end 
                else
                begin
                
                    second = (second == 0) ? 0 : second - 1;
                    first = 5;
                end
            end
            else
            first = (first == 0) ? 0 : first - 5;   
        end
        // start the countdown
        if(pressedC)
        begin
        is_timeout = 0; // start the countdown, set led to 0
            if (first == 0)
            begin
                if (second == 0 && third != 0)
                begin
                    third = third - 1;
                    second = 9;
                    first = 9;
                end
                else if (second !=0)
                begin
                    second = second - 1;
                    first = 9;               
                end
            end
            else
                first = first - 1;
        end
        if ({fourth,third,second,first} == 0)
            is_timeout = 1; // time is out, set led[0] to 1
    end
    
    // start the 7 seg
    reg [3:0] num;
    always @(an) begin
    case(an)
    4'b0111: num <= fourth;
    4'b1011: num <= third;
    4'b1101: num <= second;
    4'b1110: num <= first;
    endcase
    end
    always @(an)
    begin
        case(num)
            4'b0000 : seg = 7'b1000000;
            4'b0001 : seg = 7'b1111001;
            4'b0010 : seg = 7'b0100100;
            4'b0011 : seg = 7'b0110000;
            4'b0100 : seg = 7'b0011001;
            4'b0101 : seg = 7'b0010010;
            4'b0110 : seg = 7'b0000010;
            4'b0111 : seg = 7'b1111000;
            4'b1000 : seg = 7'b0000000;
            4'b1001 : seg = 7'b0010000;
            default : seg = 7'b1111111;
        endcase
    end 
endmodule