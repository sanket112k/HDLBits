/*
Create a 100-bit binary adder. The adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry out.
*/
module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum
);
    wire [100:0]c;
    assign c[0]=cin;
    assign cout=c[100];
    generate
        genvar i;
        for(i=0;i<100;i=i+1) begin:my_block
          //assign {c[i+1],sum[i]} = (a[i]+b[i]+c[i]);      Getting simulation error
            assign sum[i] = a[i] ^ b[i] ^ c[i];
            assign c[i+1] = (a[i] & b[i]) | (b[i] & c[i]) | (a[i] & c[i]);
        end
    endgenerate
endmodule
