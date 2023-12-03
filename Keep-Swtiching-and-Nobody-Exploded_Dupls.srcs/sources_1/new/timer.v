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
    input win,
    input restart,
    input btnC,
    input btnU,btnD,
    input clock,
    output reg is_timeout,
    output reg [6:0] seg,
    output reg [3:0] an,
    output reg [27:0] state
    );
    // for counting each second
    initial begin
        is_timeout = 1;
    end
    
    reg elapsed;
    
    // count 1 second
    always @ (posedge clock) 
    begin  
    if (state == 100000000)
        state <= 0;
    else 
        state <= state +1;
    end

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
    
    // setting up
    always @(posedge clock) 
    begin
        if (btnU && is_timeout) // press upper button and it is timeout or haven't started
        begin
            case (second)
                3: begin // 30 -> 60 seconds
                    second<=6;
                    first<=0;
                end
                6: begin // 60 -> 90 seconds
                second<=9;
                first<=0;
                end
                9: begin // 90 -> 30 seconds
                second<=3;
                first<=0;
                end
                default: begin // if the game ended, and the button is pressed, set the time to 30 seconds
                second<=3;
                first<=0;
                end
            endcase
        end 
        else if (btnD && is_timeout) 
        begin
            case (second)
                9: begin
                second<= 6;
                first<=0;
                end
                6: begin
                second <= 3;
                first<=0;
                end
                3: begin
                second <= 9;
                first<=0;
                end
                default: begin 
                second<=3;
                first<=0;
                end
            endcase
        end
        // center button is pressed, start the game
        else if(btnC || !is_timeout)
        begin
            is_timeout = 0; // start the countdown, set led to 0
            // if(state == 100000000)
            // begin
                if (first == 0 && state == 100000000 && !win) // let it count per one minute 
                begin
                    if (second == 0 && third != 0)
                    begin
                        third = third - 1;
                        second = 9;
                        first = 9;
                    end
                    else if (second !=0 && state == 100000000)
                    begin
                        second = second - 1;
                        first = 9;               
                    end
                end
                else if(first!=0 && state == 100000000 && !win)
                    first = first - 1;
                if ({fourth,third,second,first} == 0 || restart == 1) begin
                    is_timeout = 1; // time is out, set led[0] to 1
                    second <=  3;
                    first <= 0;
                end
        end
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