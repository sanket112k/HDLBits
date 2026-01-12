/*
This is the second component in a series of five exercises that builds a complex counter out of several smaller circuits. See the final exercise for the overall design.

Build a finite-state machine that searches for the sequence 1101 in an input bit stream. When the sequence is found, it should set start_shifting to 1, forever, until reset.
Getting stuck in the final state is intended to model going to other states in a bigger FSM that is not yet implemented. We will be extending this FSM in the next few exercises.
*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting
);
    reg [2:0] state, next;
    parameter [2:0] A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4;
    
    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next;
    end
    
    always @(*) begin
        case (state)
            A: next = data ? B : A;
            B: next = data ? C : A;
            C: next = data ? C : D;
            D: next = data ? E : A;
            E: next = E;
        endcase
    end
    
    assign start_shifting = (state == E);
endmodule
