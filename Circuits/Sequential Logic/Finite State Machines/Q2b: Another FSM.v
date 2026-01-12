/*
Consider a finite state machine that is used to control some type of motor. The FSM has inputs x and y, which come from the motor, and produces outputs f and g, which control the motor.
There is also a clock input called clk and a reset input called resetn.

The FSM has to work as follows. As long as the reset input is asserted, the FSM stays in a beginning state, called state A. When the reset signal is de-asserted, then after the next clock edge the
FSM has to set the output f to 1 for one clock cycle. Then, the FSM has to monitor the x input. When x has produced the values 1, 0, 1 in three successive clock cycles, then g should be set to 1
on the following clock cycle. While maintaining g = 1 the FSM has to monitor the y input. If y has the value 1 within at most two clock cycles, then the FSM should maintain g = 1 permanently
(that is, until reset). But if y does not become 1 within two clock cycles, then the FSM should set g = 0 permanently (until reset).
*/

module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
);
    reg [3:0] state, next;
    parameter [3:0] A = 'd0, FIRST = 'd1, START = 'd2, ONE = 'd3, ONEZERO = 'd4, CHECK0 = 'd5, CHECK1 = 'd6, FINAL1 = 'd7, FINAL0 = 'd8;
    
    always @(posedge clk) begin
        if (~resetn) state <= A;
        else state <= next;
    end
    
    always @(*) begin
        case (state)
            A		: next = FIRST;
            FIRST	: next = START;
            START	: next = x ? ONE : START;
            ONE		: next = x ? ONE : ONEZERO;
            ONEZERO	: next = x ? CHECK0 : START;
            CHECK0	: next = y ? FINAL1 : CHECK1;
            CHECK1	: next = y ? FINAL1 : FINAL0;
            FINAL1	: next = FINAL1;
            FINAL0	: next = FINAL0;
            default	: next = A;
        endcase
    end
    
    assign f = (state == FIRST);
    assign g = (state == CHECK0 | state == CHECK1 | state == FINAL1) && (state != FINAL0);
endmodule
