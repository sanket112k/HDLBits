/*
Consider a finite state machine with inputs s and w. Assume that the FSM begins in a reset state called A, as depicted below. The FSM remains in state A as long as s = 0, and it moves to
state B when s = 1. Once in state B the FSM examines the value of the input w in the next three clock cycles. If w = 1 in exactly two of these clock cycles, then the FSM has to set an output z
to 1 in the following clock cycle. Otherwise z has to be 0. The FSM continues checking w for the next three clock cycles, and so on. The timing diagram below illustrates the required values of z
for different values of w.

Use as few states as possible. Note that the s input is used only in state A, so you need to consider just the w input.
*/

module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    integer clkcount, wcount;
    reg state, next_state;
    parameter A = 1'b0, B = 1'b1;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            wcount = 0;
            clkcount = 0;
        end
        else begin
            state <= next_state;
            if (state == B) begin
            	if (clkcount == 3) begin clkcount = 0; wcount = 0; end
            	if (w) wcount = wcount + 1;
            	clkcount = clkcount + 1;
            end
        end
    end
    
    always @(*) begin
        case (state)
            A: next_state = s ? B : A;
            B: next_state = B;
        endcase
    end
    
    assign z = ((wcount == 2) & (clkcount == 3));
endmodule
