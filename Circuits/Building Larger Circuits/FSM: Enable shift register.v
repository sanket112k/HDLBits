/*
This is the third component in a series of five exercises that builds a complex counter out of several smaller circuits. See the final exercise for the overall design.

As part of the FSM for controlling the shift register, we want the ability to enable the shift register for exactly 4 clock cycles whenever the proper bit pattern is detected.
We handle sequence detection in Exams/review2015_fsmseq, so this portion of the FSM only handles enabling the shift register for 4 cycles.

Whenever the FSM is reset, assert shift_ena for 4 cycles, then 0 forever (until reset).
*/
module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena
);
    reg [2:0] count = 0;
    reg state;
    parameter A = 1'd0, B = 1'd1;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            count <= 0;
            shift_ena <= 1;
        end
        else begin
            case (state)
                A: begin
                    state <= (count == 2) ? B : A;
                    count <= count + 1;
                    shift_ena <= 1;
                end
                B: begin
                    state <= B;
                    shift_ena <= 0;
                end
            endcase
        end
    end
endmodule
