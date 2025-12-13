module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y 
);
    wire w0,w1,w2,w3;
    assign p1y = w0|w1;
    assign p2y = w2|w3;
    assign w0 = p1d & p1e & p1f;
    assign w1 = p1a & p1b & p1c;
    assign w2 = p2a & p2b;
    assign w3 = p2c & p2d;
endmodule
