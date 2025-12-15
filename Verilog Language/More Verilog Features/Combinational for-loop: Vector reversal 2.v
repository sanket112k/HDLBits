/* Given a 100-bit input vector [99:0], reverse its bit ordering.
*/
module top_module( 
    input [99:0] in,
    output reg [99:0] out
);
    generate
		genvar i;
        for (i=0; i<100; i = i+1) begin: my_block
            assign out[i] = in[100-i-1];
		end
	endgenerate

endmodule
