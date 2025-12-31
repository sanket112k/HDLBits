/*
You are to design a one-input one-output serial 2's complementer Moore state machine. The input (x) is a series of bits (one per clock cycle) beginning with the least-significant bit of the number,
and the output (Z) is the 2's complement of the input. The machine will accept input numbers of arbitrary length. The circuit requires an asynchronous reset.
The conversion begins when Reset is released and stops when Reset is asserted.
*/

module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg [1:0] state, next_state;
    reg r;
    parameter [1:0] ZERO = 2'd0, ONE = 2'd1, COMP = 2'd2;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin state <= ZERO; r <= 1'b0; end
        else begin state <= next_state; r <= x; end
    end
    
    always @(state or x) begin
        case(state)
            ZERO : next_state = x ? ONE : ZERO;
            ONE  : next_state = COMP;
            COMP : next_state = COMP;
            default: next_state = ZERO;
        endcase
    end
    
    always @(state or x) begin
        case(state)
            ZERO : z = 1'b0;
            ONE  : z = 1'b1;
            COMP : z = ~r;
        endcase
    end
endmodule

/*
//Alternate method

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter A=2'b00, B=2'b01, C=2'b10;
    reg [1:0] state, state_next;
    
    always @(posedge clk or posedge areset)
        begin
            if (areset)
            state <= A;
    		else
            state <= state_next;
    	end
    
    always @(*)
        begin
            case (state)
                A: begin
                    if (x) state_next <= B;
                    else   state_next <= A;
                end
                B: begin
                    if (x) state_next <= C;
                    else   state_next <= B;
                end
                C: begin
                    if (x) state_next <= C;
                    else   state_next <= B;
                end
                default:   state_next <= A;
            endcase
        end
    
    assign z = (state == B);
        
endmodule
*/
