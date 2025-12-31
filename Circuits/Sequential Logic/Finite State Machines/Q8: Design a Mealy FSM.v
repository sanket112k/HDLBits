/*
Implement a Mealy-type finite state machine that recognizes the sequence "101" on an input signal named x. Your FSM should have an output signal, z, that is asserted to logic-1 when the "101"
sequence is detected. Your FSM should also have an active-low asynchronous reset. You may only have 3 states in your state machine. Your FSM should recognize overlapping sequences.
*/

module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z
);
    reg [1:0] state, next_state;
    parameter [1:0] A = 2'd0, B = 2'd1, C = 2'd2;
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) state <= A;
        else state <= next_state;
    end
    
    always @(state or x) begin
        case (state)
            A: begin next_state = x ? B : A; z = 1'b0; end
            B: begin next_state = x ? B : C; z = 1'b0; end
            C: begin next_state = x ? B : A; z = x ? 1'b1 : 1'b0; end
            default: begin next_state = A; z = 1'b0; end
        endcase
    end
endmodule
