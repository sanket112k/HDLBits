/*
The following is the state transition table for a Moore state machine with one input, one output, and four states. Implement this state machine. Include an asynchronous reset that resets the FSM to state A.

State	Next state	Output
in=0	in=1
A	A	B	0
B	C	B	0
C	A	D	0
D	C	B	1
*/
module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    // State transition logic

    // State flip-flops with asynchronous reset

    // Output logic
    reg [1:0]state, next_state;
    parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;
    always @(*) begin
	    case(state)		
    	    A: next_state = in ? B : A;
        	B: next_state = in ? B : C;
	        C: next_state = in ? D : A;
    	    D: next_state = in ? B : C;
    	endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end
    assign out = (state == D);		
endmodule
