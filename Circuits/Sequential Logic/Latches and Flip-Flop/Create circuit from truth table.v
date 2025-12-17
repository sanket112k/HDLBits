/*
A JK flip-flop has the below truth table. Implement a JK flip-flop with only a D-type flip-flop and gates. Note: Qold is the output of the D flip-flop before the positive clock edge.
*/
module top_module (
    input clk,
    input j,
    input k,
    output Q
);
    always @(posedge clk)
        Q<=j&~Q|~k&Q;
endmodule
