/*In this exercise, you are provided with the same module add16 as the previous exercise, which adds two 16-bit numbers with carry-in and produces a carry-out and 16-bit sum.
You must instantiate three of these to build the carry-select adder, using your own 16-bit 2-to-1 multiplexer.
Connect the modules together as shown in the diagram below. The provided module add16 has the following declaration:
module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
*/

module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire w0,w1,w2,w3,w4,w5;
    wire [15:0]w6,w7;
    assign w0 = 1'b0;
    assign w2 = 1'b0;
    assign w4 = 1'b1;
    add16 inst1( a[15:0], b[15:0], w0, sum[15:0], w1);
    add16 inst2( a[31:16], b[31:16], w2, w6,w3);
    add16 inst3( a[31:16], b[31:16], w4, w7,w5);
    assign sum[31:16]=w1?w7:w6;
endmodule
