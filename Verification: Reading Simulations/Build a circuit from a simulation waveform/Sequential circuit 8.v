// This is a sequential circuit. Read the simulation waveforms to determine what the circuit does, then implement it.

module top_module (
    input clock,
    input a,
    output p,
    output q
);
    always @(clock) if(clock) p = a;
    always @(negedge clock) q = a;
endmodule
