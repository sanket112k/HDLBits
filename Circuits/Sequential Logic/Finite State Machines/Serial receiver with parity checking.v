/*
We want to add parity checking to the serial receiver. Parity checking adds one extra bit after each data byte. We will use odd parity, where the number of 1s in the 9 bits received must be odd.
For example, 101001011 satisfies odd parity (there are 5 1s), but 001001011 does not.

Change your FSM and datapath to perform odd parity checking. Assert the done signal only if a byte is correctly received and its parity check passes. Like the serial receiver FSM, this FSM needs
to identify the start bit, wait for all 9 (data and parity) bits, then verify that the stop bit was correct. If the stop bit does not appear when expected, the FSM must wait until it finds
a stop bit before attempting to receive the next byte.

You are provided with the following module that can be used to calculate the parity of the input stream (It's a TFF with reset). The intended use is that it should be given the input bit stream,
and reset at appropriate times so it counts the number of 1 bits in each byte.

module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule

Note that the serial protocol sends the least significant bit first, and the parity bit after the 8 data bits.
*/

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);
    reg [3:0] state, next_state, previous;
    reg [7:0]r;
    reg enable;
    reg odd, d_valid;
    integer i;
    parameter [3:0] STOP0 = 0, START0 = 1, D0 = 2, D1 = 3, D2 = 4, D3 = 5, D4 = 6, D5 = 7, D6 = 8, D7 = 9, D8 = 10, ERROR = 11, STOP1 = 12, START1 = 13;

    always @(*) begin 		// State transition logic (combinational)
        case(state)
            STOP0: next_state = in ? STOP0 : START0;
            START0: next_state = D0;
            D0: next_state = D1;
            D1: next_state = D2;
            D2: next_state = D3;
            D3: next_state = D4;
            D4: next_state = D5;
            D5: next_state = D6;
            D6: next_state = D7;
            D7: next_state = D8;
            D8: next_state = in ? STOP1 : ERROR;
            ERROR: next_state = in ? STOP0 : ERROR;
            STOP1: next_state = in ? STOP1 : START1;
            START1: next_state = D0;
            default: next_state = STOP0;
        endcase
    end

    always @(posedge clk) begin		// State flip-flops (sequential)
        if (reset) state <= STOP0;
        else begin
            state <= next_state;
            previous <= state;
        end
    end
    

    
    always @(posedge clk) begin		// New: Datapath to latch input bits
        if(reset) r = 8'b0;
        else begin
            if (state == START0 || state == START1) enable = 1'b1;
            else if (state == D7) enable = 1'b0;
            
            if (enable) r <= {in,r[7:1]};
        end
    end
    
    parity dut(clk, (state == STOP0 || state == STOP1), in, odd);
    
    always @(posedge clk) begin		// New: Add parity checking.
        if (reset) d_valid <= 0;
        else d_valid <= odd;
    end
    
    assign out_byte = (done) ? r : 8'b0;

    assign done = ((state == STOP1 && previous != STOP1) && (d_valid));
    
endmodule
