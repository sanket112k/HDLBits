module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
); 

    parameter [1:0] WALK_L = 2'b00, WALK_R = 2'b01, FALL_L = 2'b10, FALL_R = 2'b11;
    reg [1:0] state, next_state;

 	always @(posedge clk or posedge areset) begin
 		if(areset) state <= WALK_L;
 		else begin
 			state <= next_state;
 		end
 	end

 	always @(*) begin
 		case(state)
            WALK_L : next_state = ground ? (bump_left ? WALK_R : WALK_L) : FALL_L;
            WALK_R : next_state = ground ? (bump_right ? WALK_L : WALK_R) : FALL_R;
 			FALL_L : next_state = ground ? WALK_L : FALL_L;
 			FALL_R : next_state = ground ? WALK_R : FALL_R;
 		endcase
 	end

 	assign walk_left = (state == WALK_L);
 	assign walk_right = (state == WALK_R);
 	assign aaah = ((state == FALL_L) || (state == FALL_R));

endmodule
