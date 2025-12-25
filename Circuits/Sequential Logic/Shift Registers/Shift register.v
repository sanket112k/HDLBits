// Implement the following circuit:
module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out
);
    reg [2:0]w;
    always @(posedge clk) begin
        if(!resetn) {w,out} <= 0;
        else {w,out} <= {in,w};
    end
endmodule
