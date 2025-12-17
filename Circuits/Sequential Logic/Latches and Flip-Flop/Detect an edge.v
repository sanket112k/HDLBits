/*
For each bit in an 8-bit vector, detect when the input signal changes from 0 in one clock cycle to 1 the next (similar to positive edge detection).
The output bit should be set the cycle after a 0 to 1 transition occurs.
*/
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0]r1,r2;
    always @(posedge clk) begin
        r1<=in;
        r2<=r1;
    end
    assign pedge=r1&~r2;
endmodule
