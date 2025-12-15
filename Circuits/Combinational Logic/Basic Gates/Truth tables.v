module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    always @(*) begin
        case({x3,x2,x1})
            3'h0: f=0;
            3'h1: f=0;
            3'h2: f=1;
            3'h3: f=1;
            3'h4: f=0;
            3'h5: f=1;
            3'h6: f=0;
            3'h7: f=1;
        endcase
    end
endmodule
