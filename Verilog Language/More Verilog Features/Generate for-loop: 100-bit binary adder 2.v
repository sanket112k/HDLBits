/* Create a 100-bit binary ripple-carry adder by instantiating 100 full adders. The adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry out. 
To encourage you to actually instantiate full adders, also output the carry-out from each full adder in the ripple-carry adder. cout[99] is the final carry-out from the last full adder,
and is the carry-out you usually see.
*/
module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum
);
    generate
        genvar i;
        assign {cout[0],sum[0]} = a[0]+b[0]+cin;
        for(i=1;i<100;i=i+1) begin: my_module
            full_adder dut(a[i],b[i],cout[i-1],cout[i],sum[i]);
        end
    endgenerate
endmodule
module full_adder(
    input a,b,cin,
    output cout,sum
);
    assign {cout,sum} = a+b+cin;
endmodule
