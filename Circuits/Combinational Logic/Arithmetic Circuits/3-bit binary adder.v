/*
Now that you know how to build a full adder, make 3 instances of it to create a 3-bit binary ripple-carry adder. The adder adds two 3-bit numbers and a carry-in to produce a 3-bit sum and carry out.
To encourage you to actually instantiate full adders, also output the carry-out from each full adder in the ripple-carry adder. cout[2] is the final carry-out from the last full adder, and is the
carry-out you usually see.
*/
module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum
);
    full_adder(a[0],b[0],cin,cout[0],sum[0]);
    full_adder(a[1],b[1],cout[0],cout[1],sum[1]);
    full_adder(a[2],b[2],cout[1],cout[2],sum[2]);
endmodule

module full_adder( 
    input a, b,cin,
    output cout,sum
);
    assign {cout,sum} = a+b+cin;
endmodule
