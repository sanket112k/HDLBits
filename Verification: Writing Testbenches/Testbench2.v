/*
The waveform below sets clk, in, and s:

Module q7 has the following declaration:

module q7 (
    input clk,
    input in,
    input [2:0] s,
    output out
);
Write a testbench that instantiates module q7 and generates these input signals exactly as shown in the waveform above.
*/

module top_module();
    reg clk;
    reg in;
    reg [2:0]s;
    wire out;
    
    q7 dut(clk, in, s, out);
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        in = 0; s = 2;
        @(negedge clk) begin in = 0; s = 6; end
        @(negedge clk) begin in = 1; s = 2; end
        @(negedge clk) begin in = 0; s = 7; end
        repeat (3) @(negedge clk) begin in = 1; s = 0; end
        @(negedge clk) begin in = 0; s = 0; end
    end
endmodule
