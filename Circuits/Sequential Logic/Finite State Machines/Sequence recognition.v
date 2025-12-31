/*
Synchronous HDLC framing involves decoding a continuous bit stream of data to look for bit patterns that indicate the beginning and end of frames (packets). Seeing exactly 6 consecutive 1s 
(i.e., 01111110) is a "flag" that indicate frame boundaries. To avoid the data stream from accidentally containing "flags", the sender inserts a zero after every 5 consecutive 1s which the
receiver must detect and discard. We also need to signal an error if there are 7 or more consecutive 1s.

Create a finite state machine to recognize these three sequences:

0111110: Signal a bit needs to be discarded (disc).
01111110: Flag the beginning/end of a frame (flag).
01111111...: Error (7 or more 1s) (err).
When the FSM is reset, it should be in a state that behaves as though the previous input were 0.

Here are some example sequences that illustrate the desired operation.
*/

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);
    reg [3:0] state, next_state;
    parameter [3:0] ZERO = 4'd0, ONE1 = 4'd1, ONE2 = 4'd2, ONE3 = 4'd3, ONE4 = 4'D4, ONE5 = 4'd5, ONE6 = 4'd6, DISC = 4'd7, FLAG = 4'd8, ERR = 4'd9;
    
    always @(state or in) begin
        case(state)
            ZERO: next_state = (in) ? ONE1 : ZERO;
            ONE1: next_state = (in) ? ONE2 : ZERO;
            ONE2: next_state = (in) ? ONE3 : ZERO;
            ONE3: next_state = (in) ? ONE4 : ZERO;
            ONE4: next_state = (in) ? ONE5 : ZERO;
            ONE5: next_state = (in) ? ONE6 : DISC;
            ONE6: next_state = (in) ? ERR  : FLAG;
            DISC: next_state = (in) ? ONE1 : ZERO;
            FLAG: next_state = (in) ? ONE1 : ZERO;
            ERR : next_state = (in) ? ERR  : ZERO;
            default: next_state = ZERO;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) state <= ZERO;
        else state <= next_state;
    end
    
    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err  = (state == ERR);
endmodule
