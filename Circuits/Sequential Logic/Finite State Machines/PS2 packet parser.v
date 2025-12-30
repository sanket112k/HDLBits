/*
The PS/2 mouse protocol sends messages that are three bytes long. However, within a continuous byte stream, it's not obvious where messages start and end. The only indication is that the first byte of each three byte message always has bit[3]=1 (but bit[3] of the other two bytes may be 1 or 0 depending on data).

We want a finite state machine that will search for message boundaries when given an input byte stream. The algorithm we'll use is to discard bytes until we see one with bit[3]=1. We then assume that this is byte 1 of a message, and signal the receipt of a message once all 3 bytes have been received (done).

The FSM should signal done in the cycle immediately after the third byte of each message was successfully received.
*/

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done
);
    reg [1:0] state, next_state;
    parameter [1:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3;

    always @(*) begin 		// State transition logic (combinational)
        case(state)
            S0: next_state = in[3] ? S1 : S0;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = in[3] ? S1 : S0;
            default: next_state = 3'bx;
        endcase
    end

    always @(posedge clk) begin		// State flip-flops (sequential)
        if (reset) state <= S0;
        else state <= next_state;
    end
    
    assign done = (state == S3);	// Output logic

endmodule
