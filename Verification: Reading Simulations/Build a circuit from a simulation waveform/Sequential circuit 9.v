// This is a sequential circuit. Read the simulation waveforms to determine what the circuit does, then implement it.
module top_module (
    input clk,
    input a,
    output [3:0] q
);
    always @(posedge clk) begin
        if (a) q <= 4'd4;
        else if (q==6) q <= 4'd0;
        else q <= q + 4'd1;
    end
endmodule
