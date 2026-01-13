/*
This is a sequential circuit. The circuit consists of combinational logic and one bit of memory (i.e., one flip-flop). The output of the flip-flop has been made observable through the output state.

Read the simulation waveforms to determine what the circuit does, then implement it.
*/
module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);
    reg next;
    assign next = ~a & b & state | a & (b | state);
    always @(posedge clk) state <= next;
    assign q = a^b^state;
endmodule
