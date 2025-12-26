/*
This is a Moore state machine with two states, two inputs, and one output. Implement this state machine.

This exercise is the same as fsm2, but using synchronous reset.
*/
module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        case(state)		// State transition logic
            OFF: next_state = j ? ON : OFF;
            ON: next_state = k ? OFF : ON;
        endcase
    end

    always @(posedge clk) begin
        if (reset) state <= OFF; 		// State flip-flops with asynchronous reset
        else state <= next_state;
    end

    // Output logic
    assign out = (state == ON);

endmodule
