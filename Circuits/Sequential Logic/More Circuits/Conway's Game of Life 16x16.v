/*
Conway's Game of Life is a two-dimensional cellular automaton.

The "game" is played on a two-dimensional grid of cells, where each cell is either 1 (alive) or 0 (dead). At each time step, each cell changes state depending on how many neighbours it has:

0-1 neighbour: Cell becomes 0.
2 neighbours: Cell state does not change.
3 neighbours: Cell becomes 1.
4+ neighbours: Cell becomes 0.
The game is formulated for an infinite grid. In this circuit, we will use a 16x16 grid. To make things more interesting, we will use a 16x16 toroid, where the sides wrap around to the other side of the grid. For example, the corner cell (0,0) has 8 neighbours: (15,1), (15,0), (15,15), (0,1), (0,15), (1,1), (1,0), and (1,15). The 16x16 grid is represented by a length 256 vector, where each row of 16 cells is represented by a sub-vector: q[15:0] is row 0, q[31:16] is row 1, etc. (This tool accepts SystemVerilog, so you may use 2D vectors if you wish.)

load: Loads data into q at the next clock edge, for loading initial state.
q: The 16x16 current state of the game, updated every clock cycle.
The game state should advance by one timestep every clock cycle.
*/
module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q
);
    integer i, alive;
    always @(posedge clk) begin
        if (load) q<= data;
        else begin
            for (i=0;i<=255;i=i+1) begin
                if (i==0) alive = q[255]+q[240]+q[241]+q[15]+q[1]+q[31]+q[16]+q[17];
                else if (i==15) alive = q[254]+q[255]+q[240]+q[14]+q[0]+q[30]+q[31]+q[16];
                else if (i==240) alive = q[239]+q[224]+q[225]+q[255]+q[241]+q[15]+q[0]+q[1];
                else if (i==255) alive = q[238]+q[239]+q[224]+q[254]+q[240]+q[14]+q[15]+q[0];
                else if (i<15) alive = q[i+239]+q[i+240]+q[i+241]+q[i-1]+q[i+1]+q[i+15]+q[i+16]+q[i+17];
                else if (!(i%16)) alive = q[i-1]+q[i-16]+q[i-15]+q[i+15]+q[i+1]+q[i+31]+q[i+16]+q[i+17];
                else if (!((i+1)%16)) alive = q[i-17]+q[i-16]+q[i-31]+q[i-1]+q[i-15]+q[i+15]+q[i+16]+q[i+1];
                else if (i>240) alive = q[i-17]+q[i-16]+q[i-15]+q[i-1]+q[i+1]+q[i-241]+q[i-240]+q[i-239];
                else alive = q[i-17]+q[i-16]+q[i-15]+q[i-1]+q[i+1]+q[i+15]+q[i+16]+q[i+17];
                
                if(alive < 2) q[i] <= 1'b0;
                else if(alive == 2) q[i] <= q[i];
                else if(alive == 3) q[i] <= 1'b1;
                else q[i] <= 1'b0;
            end
        end
    end
endmodule
