/*
Consider the n-bit shift register circuit shown below:



Write a top-level Verilog module (named top_module) for the shift register, assuming that n = 4. Instantiate four copies of your MUXDFF subcircuit in your top-level module. Assume that you are going to implement the circuit on the DE2 board.

Connect the R inputs to the SW switches,
clk to KEY[0],
E to KEY[1],
L to KEY[2], and
w to KEY[3].
Connect the outputs to the red lights LEDR[3:0].
(Reuse your MUXDFF from exams/2014_q4a.)
*/
module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    MUXDFF dut3(.clk(KEY[0]), .w(KEY[3]), .R(SW[3]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[3]));
    MUXDFF dut2(.clk(KEY[0]), .w(LEDR[3]), .R(SW[2]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[2]));
    MUXDFF dut1(.clk(KEY[0]), .w(LEDR[2]), .R(SW[1]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[1]));
    MUXDFF dut0(.clk(KEY[0]), .w(LEDR[1]), .R(SW[0]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[0]));
endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output Q
);
    always @(posedge clk) begin
        if(L) Q <= R;
        else if(E) Q <= w;
    end
endmodule
