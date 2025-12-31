/*
Given the state-assigned table shown below, implement the logic functions Y[0] and z.

Present state
y[2:0]	Next state Y[2:0]	Output z
x=0	x=1
000	000	001	0
001	001	100	0
010	010	001	0
011	001	010	1
100	011	100	1
*/

module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    wire [1:0]w;
    reg [2:0] state, next_state;
    parameter [2:0] A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4;
    
    assign state = y;
    
    always @(state or x) begin
        case(state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
            default: next_state = A;
        endcase
    end
    
    assign z = (state == D | state == E);
    assign {w,Y0} = (state == A | state == C) & x | (state == B | state == D | state == E) & ~x;
endmodule
