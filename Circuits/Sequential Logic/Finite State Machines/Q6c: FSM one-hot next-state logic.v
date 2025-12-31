/*
Consider the state machine shown below, which has one input w and one output z.



For this part, assume that a one-hot code is used with the state assignment 'y[6:1] = 000001, 000010, 000100, 001000, 010000, 100000 for states A, B,..., F, respectively.

Write a logic expression for the next-state signals Y2 and Y4. (Derive the logic equations by inspection assuming a one-hot encoding. The testbench will test with non-one hot inputs to make
sure you're not trying to do something more complicated).
*/

module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    reg [6:1] Y;
    parameter A=1, B=2, C=3, D=4, E=5, F=6;
    
    assign Y[A] = (y[A] | y[D]) & w;
    assign Y[B] = y[A] & ~w;
    assign Y[C] = (y[B] | y[F]) & ~w;
    assign Y[D] = (y[B] | y[C] | y[E] | y[F]) & w;
    assign Y[E] = (y[C] | y[E]) & ~w;
    assign Y[F] = y[D] & ~w;
    
    assign Y2 = Y[2];
    assign Y4 = Y[4];
endmodule
