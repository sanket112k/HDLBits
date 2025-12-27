module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);
    reg [2:0] state, next_state;
    parameter EMPTY = 3'd0,
    L1L = 3'd1,		//Privious level is low
    L1H = 3'd2,		//Privious level is high
    L2L = 3'd3,		//Privious level is low
    L2H = 3'd4,		//Privious level is high
    FULL= 3'd5;
    
    always @(*) begin
        case(state)		
            EMPTY: next_state = s[1] ? L1L : EMPTY;
            L1L: next_state = s[2] ? L2L : s[1] ? L1L : EMPTY;
            L1H: next_state = s[2] ? L2L : s[1] ? L1H : EMPTY;
            L2L: next_state = s[3] ? FULL : s[2] ? L2L : L1H;
            L2H: next_state = s[3] ? FULL : s[2] ? L2H : L1H;
            FULL: next_state = s[3] ? FULL : L2H;
            default : next_state = 3'bxxx;
    	endcase
    end
    
    always @(posedge clk) begin
        if (reset) state <= EMPTY;
        else  state <= next_state;
    end
    
    always @(*) begin
        case(state)		
            EMPTY: {fr3, fr2, fr1, dfr} = 4'b1111;
            L1L: {fr3, fr2, fr1, dfr} = 4'b0110;
            L1H: {fr3, fr2, fr1, dfr} = 4'b0111;
            L2L: {fr3, fr2, fr1, dfr} = 4'b0010;
            L2H: {fr3, fr2, fr1, dfr} = 4'b0011;
            FULL: {fr3, fr2, fr1, dfr} = 4'b0000;
            default : next_state = 4'bxxxx;
    	endcase
    end
endmodule
