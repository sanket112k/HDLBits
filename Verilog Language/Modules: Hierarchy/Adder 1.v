module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire w,w1;
    assign w1 = 1'b0;
    add16 inst1( a[15:0], b[15:0], w1, sum[15:0], w);
    add16 inst2( a[31:16], b[31:16], w, sum[31:16]);
endmodule
