/*
This is the fifth component in a series of five exercises that builds a complex counter out of several smaller circuits. You may wish to do the four previous exercises first (counter, sequence
recognizer FSM, FSM delay, and combined FSM).

We want to create a timer with one input that:

is started when a particular input pattern (1101) is detected,
shifts in 4 more bits to determine the duration to delay,
waits for the counters to finish counting, and
notifies the user and waits for the user to acknowledge the timer.
The serial data is available on the data input pin. When the pattern 1101 is received, the circuit must then shift in the next 4 bits, most-significant-bit first. These 4 bits determine the
duration of the timer delay. I'll refer to this as the delay[3:0].

After that, the state machine asserts its counting output to indicate it is counting. The state machine must count for exactly (delay[3:0] + 1) * 1000 clock cycles. e.g., delay=0 means count
1000 cycles, and delay=5 means count 6000 cycles. Also output the current remaining time. This should be equal to delay for 1000 cycles, then delay-1 for 1000 cycles, and so on until it is 0 for
1000 cycles. When the circuit isn't counting, the count[3:0] output is don't-care (whatever value is convenient for you to implement).

At that point, the circuit must assert done to notify the user the timer has timed out, and waits until input ack is 1 before being reset to look for the next occurrence of the start sequence
(1101).

The circuit should reset into a state where it begins searching for the input sequence 1101.

Here is an example of the expected inputs and outputs. The 'x' states may be slightly confusing to read. They indicate that the FSM should not care about that particular input signal in that cycle.
For example, once the 1101 and delay[3:0] have been read, the circuit no longer looks at the data input until it resumes searching after everything else is done. In this example, the circuit counts
for 2000 clock cycles because the delay[3:0] value was 4'b0001. The last few cycles starts another count with delay[3:0] = 4'b1110, which will count for 15000 cycles.
*/

module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack
);
    int i,j;
    reg [3:0] delay;
    reg [2:0] state, next;
    parameter [2:0] A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, SHIFT = 3'd4, COUNTING = 3'd5, DONE = 3'd6;
    
    always @(posedge clk) begin
        if (reset) state <= A;
        else state <= next;
    end
    
    always @(*) begin
        case (state)
            A: next = data ? B : A;
            B: next = data ? C : A;
            C: next = data ? C : D;
            D: next = data ? SHIFT : A;
            SHIFT	: next = (i == 3) ? COUNTING : SHIFT;
            COUNTING: next = (j == (delay + 1) * 1000 - 1) ? DONE : COUNTING;
            DONE	: next = ack ? A : DONE;
        endcase
    end
    
    always @(posedge clk) begin
        if (state == SHIFT) begin
            i <= i + 1;
            delay <= {delay[2:0], data};
        end
        else i <= 0;
    end
    
    always @(posedge clk) begin
        if (state == COUNTING) begin
            if (reset | j == (delay + 1) * 1000 - 1) j <= 0;
            else j <= j + 1;
        end
    end
    
    assign count = delay - j/1000;
    assign counting = (state == COUNTING);
    assign done = (state == DONE);
endmodule
