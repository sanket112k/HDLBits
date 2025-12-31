/*
The state diagram for this question is shown again below.



Assume that a one-hot code is used with the state assignment y[5:0] = 000001(A), 000010(B), 000100(C), 001000(D), 010000(E), 100000(F)

Write a logic expression for the signal Y1, which is the input of state flip-flop y[1].

Write a logic expression for the signal Y3, which is the input of state flip-flop y[3].
*/

module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    reg [5:0] Y;
    parameter A=0, B=1, C=2, D=3, E=4, F=5;
    
    assign Y[A] = (y[A] | y[D]) & ~w;
    assign Y[B] = y[A] & w;
    assign Y[C] = (y[B] | y[F]) & w;
    assign Y[D] = (y[B] | y[C] | y[E] | y[F]) & ~w;
    assign Y[E] = (y[C] | y[E]) & w;
    assign Y[F] = y[D] & w;
    
    assign Y1 = Y[1];
    assign Y3 = Y[3];
endmodule
