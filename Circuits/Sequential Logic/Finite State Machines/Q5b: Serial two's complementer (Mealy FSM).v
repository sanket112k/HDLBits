// The following diagram is a Mealy machine implementation of the 2's complementer. Implement using one-hot encoding.

module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg state, next_state;
    parameter A = 0, B = 1;
    
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end
    
    always @(state or x) begin
        case(state)
            A: begin next_state = x ? B : A; z = x ? 1'b1 : 1'b0; end
            B: begin next_state = B; z = x ? 1'b0 : 1'b1; end
        endcase
    end
    
endmodule
