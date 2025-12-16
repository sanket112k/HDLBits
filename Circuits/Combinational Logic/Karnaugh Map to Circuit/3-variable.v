// Implement the circuit described by the Karnaugh map below.
module top_module(
    input a,
    input b,
    input c,
    output out
);
    assign out = a|b|c;
endmodule
