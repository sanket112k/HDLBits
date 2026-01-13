// This is a combinational circuit. Read the simulation waveforms to determine what the circuit does, then implement it.
module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    assign q = ~a^b^c^d; // Fix me

endmodule
