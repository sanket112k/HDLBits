/*
Assume that you have two 8-bit 2's complement numbers, a[7:0] and b[7:0]. These numbers are added to produce s[7:0]. Also compute whether a (signed) overflow has occurred.
*/
module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire [8:0]cout;
    assign cout[0]=1'b0;
    generate
        genvar i;
        for(i=0;i<8;i=i+1) begin:my_block
            assign {cout[i+1],s[i]} = a[i]+b[i]+cout[i];
        end
    endgenerate
    assign overflow = cout[8]^cout[7];
endmodule
