/*
In addition to walking and falling, Lemmings can sometimes be told to do useful things, like dig (it starts digging when dig=1). A Lemming can dig if it is currently walking on ground (ground=1 and not falling), and will continue digging until it reaches the other side (ground=0). At that point, since there is no ground, it will fall (aaah!), then continue walking in its original direction once it hits ground again. As with falling, being bumped while digging has no effect, and being told to dig when falling or when there is no ground is ignored.

(In other words, a walking Lemming can fall, dig, or switch directions. If more than one of these conditions are satisfied, fall has higher precedence than dig, which has higher precedence than switching directions.)

Extend your finite state machine to model this behaviour.
*/

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
