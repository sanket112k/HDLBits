/*
In many (older) serial communications protocols, each data byte is sent along with a start bit and a stop bit, to help the receiver delimit bytes from the stream of bits.
One common scheme is to use one start bit (0), 8 data bits, and 1 stop bit (1). The line is also at logic 1 when nothing is being transmitted (idle).

Design a finite state machine that will identify when bytes have been correctly received when given a stream of bits. It needs to identify the start bit, wait for all 8 data bits,
then verify that the stop bit was correct. If the stop bit does not appear when expected, the FSM must wait until it finds a stop bit before attempting to receive the next byte.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
);
    reg [3:0] state, next_state, previous;
    parameter [3:0] STOP0 = 0, START0 = 1, D0 = 2, D1 = 3, D2 = 4, D3 = 5, D4 = 6, D5 = 7, D6 = 8, D7 = 9, ERROR = 10, STOP1 = 11, START1 = 12;

    always @(*) begin 		// State transition logic (combinational)
        case(state)
            STOP0: next_state = in ? STOP0 : START0;
            START0: next_state = D0;
            D0: next_state = D1;
            D1: next_state = D2;
            D2: next_state = D3;
            D3: next_state = D4;
            D4: next_state = D5;
            D5: next_state = D6;
            D6: next_state = D7;
            D7: next_state = in ? STOP1 : ERROR;
            ERROR: next_state = in ? STOP0 : ERROR;
            STOP1: next_state = in ? STOP1 : START1;
            START1: next_state = D0;
            default: next_state = STOP0;
        endcase
    end

    always @(posedge clk) begin		// State flip-flops (sequential)
        if (reset) state <= STOP0;
        else begin
            state <= next_state;
            previous <= state;
        end
    end
    
    assign done = (state == STOP1 && previous != STOP1);	// Output logic

endmodule
