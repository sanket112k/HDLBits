/*In this exercise, you will create a circuit with two levels of hierarchy. Your top_module will instantiate two copies of add16 (provided), 
each of which will instantiate 16 copies of add1 (which you must write). Thus, you must write two modules: top_module and add1.
Like module_add, you are given a module add16 that performs a 16-bit addition. You must instantiate two of them to create a 32-bit adder. 
One add16 module computes the lower 16 bits of the addition result, while the second add16 module computes the upper 16 bits of the result. 
Your 32-bit adder does not need to handle carry-in (assume 0) or carry-out (ignored).
Connect the add16 modules together as shown in the diagram below. The provided module add16 has the following declaration:
module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );
Within each add16, 16 full adders (module add1, not provided) are instantiated to actually perform the addition. You must write the full adder module that has the following declaration:
module add1 ( input a, input b, input cin, output sum, output cout );
Recall that a full adder computes the sum and carry-out of a+b+cin.
In summary, there are three modules in this design:
top_module — Your top-level module that contains two of...
add16, provided — A 16-bit adder module that is composed of 16 of...
add1 — A 1-bit full adder module.
If your submission is missing a module add1, you will get an error message that says Error (12006): Node instance "user_fadd[0].a1" instantiates undefined entity "add1".
*/

module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire w2, w1, w3;
    assign w1 = 1'b0;
    add16 inst1( a[15:0], b[15:0], w1, sum[15:0], w2);
    add16 inst2( a[31:16], b[31:16], w2, sum[31:16], w3);
endmodule
/*
module add16 (
    input[15:0]a,
    input[15:0]b,
    input cin,
    output[15:0]sum,
    output cout
);
    wire [14:0]w;
    add1 ins0(a[0],b[0],cin,sum[0],w[0]);
    add1 ins1(a[1],b[1],w[0],sum[1],w[1]);
    add1 ins2(a[2],b[2],w[1],sum[2],w[2]);
    add1 ins3(a[3],b[3],w[2],sum[3],w[3]);
    add1 ins4(a[4],b[4],w[3],sum[4],w[4]);
    add1 ins5(a[5],b[5],w[4],sum[5],w[5]);
    add1 ins6(a[6],b[6],w[5],sum[6],w[6]);
    add1 ins7(a[7],b[7],w[6],sum[7],w[7]);
    add1 ins8(a[8],b[8],w[7],sum[8],w[8]);
    add1 ins9(a[9],b[9],w[8],sum[9],w[9]);
    add1 ins10(a[10],b[10],w[9],sum[10],w[10]);
    add1 ins11(a[11],b[11],w[10],sum[11],w[11]);
    add1 ins12(a[12],b[12],w[11],sum[12],w[12]);
    add1 ins13(a[13],b[13],w[12],sum[13],w[13]);
    add1 ins14(a[14],b[14],w[13],sum[14],w[14]);
    add1 ins15(a[15],b[15],w[14],sum[15],cout);
endmodule
*/
module add1(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    assign {cout,sum} = a + b + cin;
endmodule
