module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
); 

    parameter [3:0] WALK_L = 3'd0, WALK_R = 3'd1, FALL_L = 3'd2, FALL_R = 3'd3, DIG_L = 3'd4, DIG_R = 3'd5;
    reg [3:0] state, next_state;

 	always @(posedge clk or posedge areset) begin
 		if(areset) state <= WALK_L;
 		else begin
 			state <= next_state;
 		end
 	end

 	always @(*) begin
 		case(state)
      WALK_L : next_state = ground ? (dig ? DIG_L : (bump_left ? WALK_R : WALK_L)) : FALL_L;
      WALK_R : next_state = ground ? (dig ? DIG_R : (bump_right ? WALK_L : WALK_R)) : FALL_R;
 			FALL_L : next_state = ground ? WALK_L : FALL_L;
 			FALL_R : next_state = ground ? WALK_R : FALL_R;
      DIG_L : next_state = ground ? DIG_L : FALL_L;
      DIG_R : next_state = ground ? DIG_R : FALL_R;
 		endcase
 	end

 	assign walk_left = (state == WALK_L);
 	assign walk_right = (state == WALK_R);
 	assign aaah = ((state == FALL_L) || (state == FALL_R));
  assign digging = ((state == DIG_L) || (state == DIG_R));
endmodule
