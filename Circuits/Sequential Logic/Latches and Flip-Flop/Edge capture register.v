/* For each bit in a 32-bit vector, capture when the input signal changes from 1 in one clock cycle to 0 the next.
"Capture" means that the output will remain 1 until the register is reset (synchronous reset).

Each output bit behaves like a SR flip-flop: The output bit should be set (to 1) the cycle after a 1 to 0 transition occurs.
The output bit should be reset (to 0) at the positive clock edge when reset is high. If both of the above events occur at the same time, reset has precedence.
In the last 4 cycles of the example waveform below, the 'reset' event occurs one cycle earlier than the 'set' event, so there is no conflict here.
*/
module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0]in_prev;
    integer i;
    always @(posedge clk) begin
        in_prev <= in;
        if (reset)
            out<=0;
        else begin
            for (i=0; i<32;i=i+1)
                if (in_prev[i]==1 && in[i]==0) out[i]<=1;
        end
    end
endmodule
