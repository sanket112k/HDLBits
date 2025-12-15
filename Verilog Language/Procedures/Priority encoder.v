/*A priority encoder is a combinational circuit that, when given an input bit vector, outputs the position of the first 1 bit in the vector. 
For example, a 8-bit priority encoder given the input 8'b10010000 would output 3'd4, because bit[4] is first bit that is high.

Build a 4-bit priority encoder. For this problem, if none of the input bits are high (i.e., input is zero), output zero. Note that a 4-bit number has 16 possible combinations.
*/
module top_module (
    input [3:0] in,
    output reg [1:0] pos
);
    always @(*) begin
        case(in)
            4'h0: pos = 2'd0;
            4'h1: pos = 2'd0;
            4'h2: pos = 2'd1;
            4'h3: pos = 2'd0;
            4'h4: pos = 2'd2;
            4'h5: pos = 2'd0;
            4'h6: pos = 2'd1;
            4'h7: pos = 2'd0;
            4'h8: pos = 2'd3;
            4'h9: pos = 2'd0;
            4'ha: pos = 2'd1;
            4'hb: pos = 2'd0;
            4'hc: pos = 2'd2;
            4'hd: pos = 2'd0;
            4'he: pos = 2'd1;
            4'hf: pos = 2'd0;
        endcase
    end
endmodule
