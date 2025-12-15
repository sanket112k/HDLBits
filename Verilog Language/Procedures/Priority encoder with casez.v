/* Build a priority encoder for 8-bit inputs. Given an 8-bit vector, the output should report the first (least significant) bit in the vector that is 1. 
Report zero if the input vector has no bits that are high. For example, the input 8'b10010000 should output 3'd4, because bit[4] is first bit that is high.

From the previous exercise (always_case2), there would be 256 cases in the case statement. We can reduce this (down to 9 cases) if the case items in the case statement supported don't-care bits. 
This is what casez is for: It treats bits that have the value z as don't-care in the comparison.
*/
module top_module (
    input [7:0] in,
    output reg [2:0] pos
);
    always @(*) begin
        casez(in)
            8'bzzzzzzz1: pos = 0;
            8'bzzzzzz10: pos = 1;
            8'bzzzzz100: pos = 2;
            8'bzzzz1000: pos = 3;
            8'bzzz10000: pos = 4;
            8'bzz100000: pos = 5;
            8'bz1000000: pos = 6;
            8'b10000000: pos = 7;
            default: pos = 0;
        endcase
    end
endmodule
