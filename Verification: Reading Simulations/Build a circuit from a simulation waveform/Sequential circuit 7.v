// This is a sequential circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

module top_module (
    input clk,
    input a,
    output q
);
    always @(posedge clk) q <= ~a;
endmodule
