/*
You are provided with a BCD (binary-coded decimal) one-digit adder named bcd_fadd that adds two BCD digits and carry-in, and produces a sum and carry-out.

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
Instantiate 4 copies of bcd_fadd to create a 4-digit BCD ripple-carry adder. Your adder should add two 4-digit BCD numbers (packed into 16-bit vectors) and a carry-in to produce a 4-digit sum and carry out.
*/
module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum
);
    wire [4:0]c;
    assign c[0]=cin;
    assign cout=c[4];
    generate
        genvar i;
        for(i=0;i<4;i=i+1) begin: my_block
            bcd_fadd dut(a[i*4 +: 4],b[i*4 +: 4],c[i],c[i+1],sum[i*4 +: 4]);
        end
    endgenerate
endmodule
