/*
Consider the state machine shown below, which has one input w and one output z.



Assume that you wish to implement the FSM using three flip-flops and state codes y[3:1] = 000, 001, ... , 101 for states A, B, ... , F, respectively.
Show a state-assigned table for this FSM. Derive a next-state expression for the flip-flop y[2].

Implement just the next-state logic for y[2]. (This is much more a FSM question than a Verilog coding question. Oh well.)
*/

module top_module (
    input [3:1] y,
    input w,
    output Y2
);
    reg [3:1]Y;
    parameter [3:1] A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'D5;
    
    always @(y or w) begin
        case (y)
            A : Y = w ? A : B;
            B : Y = w ? D : C;
            C : Y = w ? D : E;
            D : Y = w ? A : F;
            E : Y = w ? D : E;
            F : Y = w ? D : C;
            default: Y = A;
        endcase
    end
    
    assign Y2 = Y[2];
endmodule
