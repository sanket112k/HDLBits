module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done
);
    reg [1:0] state, next_state;
    parameter [1:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3;

    always @(*) begin 		// State transition logic (combinational)
        case(state)
            S0: next_state = in[3] ? S1 : S0;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = in[3] ? S1 : S0;
            default: next_state = 3'bx;
        endcase
    end

    always @(posedge clk) begin		// State flip-flops (sequential)
        if (reset) state <= S0;
        else state <= next_state;
    end
    
    assign done = (state == S3);	// Output logic

endmodule
