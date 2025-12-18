/*
Build a 4-digit BCD (binary-coded decimal) counter. Each decimal digit is encoded using 4 bits: q[3:0] is the ones digit, q[7:4] is the tens digit, etc. For digits [3:1],
also output an enable signal indicating when each of the upper three digits should be incremented.

You may want to instantiate or modify some one-digit decade counters.
*/
module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q
);
    assign ena[1] = q[3:0]==9?1'b1:1'b0;
    assign ena[2] = (q[7:4]==9 && q[3:0]==9)?1'b1:1'b0;
    assign ena[3] = (q[11:8]==9 && q[7:4]==9 && q[3:0]==9)?1'b1:1'b0;
    decade_counter dut0(clk,reset,1'b1,q[3:0]);
    decade_counter dut1(clk,reset,ena[1],q[7:4]);
    decade_counter dut2(clk,reset,ena[2],q[11:8]);
    decade_counter dut3(clk,reset,ena[3],q[15:12]);
endmodule

module decade_counter (
    input clk,
    input reset,        // Synchronous active-high reset
    input en,
    output [3:0] q
);
    initial q=0;
    always @(posedge clk) begin
        if(reset) q<=0;
        else begin
            if (en) begin
                if (q==9) q<=0;
            	else q<=q+1;
        	end
        end
    end
endmodule
