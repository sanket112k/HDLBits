/* The following is the state transition table for a Moore state machine with one input, one output, and four states. Use the following state encoding: A=2'b00, B=2'b01, C=2'b10, D=2'b11.

Implement only the state transition logic and output logic (the combinational logic portion) for this state machine. Given the current state (state), compute the next_state and output (out) based on the state transition table.

State	Next state	Output
in=0	in=1
A	A	B	0
B	C	B	0
C	A	D	0
D	C	B	1
*/
module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out
); //

    parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;
    always @(*) begin
	    case(state)		// State transition logic: next_state = f(state, in)
    	    A: next_state = in ? B : A;
        	B: next_state = in ? B : C;
	        C: next_state = in ? D : A;
    	    D: next_state = in ? B : C;
    	endcase
    end
    assign out = (state == D);		// Output logic:  out = f(state) for a Moore state machine
endmodule
