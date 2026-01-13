/*
You are given the following AND gate you wish to test:

module andgate (
    input [1:0] in,
    output out
);
Write a testbench that instantiates this AND gate and tests all 4 input combinations, by generating the following timing diagram:
*/
module top_module();
    reg [1:0]in;
    wire out;
    andgate dut(in, out);
    initial begin
        in = 2'd0;
        repeat (3) #10 in = in + 1;
    end
endmodule
