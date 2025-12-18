/*
Create a set of counters suitable for use as a 12-hour clock (with am/pm indicator). Your counters are clocked by a fast-running clk, with a pulse on ena whenever your clock should increment
(i.e., once per second).

reset resets the clock to 12:00 AM. pm is 0 for AM and 1 for PM. hh, mm, and ss are two BCD (Binary-Coded Decimal) digits each for hours (01-12), minutes (00-59), and seconds (00-59). 
Reset has higher priority than enable, and can occur even when not enabled.

The following timing diagram shows the rollover behaviour from 11:59:59 AM to 12:00:00 PM and the synchronous reset and enable behaviour.
*/

module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);
    reg m_ena, h_ena, pm_ena;
    reg [3:0]s_reset_value, m_reset_value, h_reset_value;
    assign s_reset_value = 4'd0;
    assign m_reset_value = 4'd0;
    sec_counter s(clk, reset,   ena, ss, m_ena);
    min_counter m(clk, reset, m_ena, ss, mm, h_ena);
    hrs_counter h(clk, reset, h_ena, ss, mm, hh, pm_ena);
    always @(posedge clk) begin
        pm = (reset) ? 1'b0 : (pm_ena==1? ~pm : pm);
    end
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module hrs_counter(
    input clk,
    input reset,
    input h_ena,
    input [7:0]ss,
    input [7:0]mm,
    output [7:0]q,
    output pm_ena
);
    initial q=8'h12;
    always @(posedge clk) begin
        if(reset) q<=8'h12;
        else begin
            if (h_ena) begin
                if (q==8'h09) q<=8'h10;
                else if (q==8'h12) q<=8'h01;
                else q[3:0]<=q[3:0]+4'b0001;
                //end_ena = (q==8'h11)?1'b1:1'b0;
        	end
        end
    end
    //assign end_ena = (q==8'h11)?1'b1:1'b0;
    assign pm_ena = (h_ena) ? ((q==8'h11)?1'b1:1'b0) : 1'b0;
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module min_counter(
    input clk,
    input reset,
    input m_ena,
    input [7:0]ss,
    output [7:0]q,
    output h_ena
);
    reg m2_ena;
    //assign en[0] = m_ena;
    assign m2_ena = (m_ena) ? ((q[3:0]==4'h9)?1'b1:1'b0) : 1'b0;
    decade_counter #(.N(10)) dut0(clk, reset,  m_ena, q[3:0]);
    decade_counter #(.N(6))  dut1(clk, reset, m2_ena, q[7:4]);
    
    assign h_ena = (m_ena) ? ((q==8'h59)?1'b1:1'b0) : 1'b0;
endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module sec_counter(
    input clk,
    input reset,
    input ena,
    output [7:0]q,
    output m_ena
);
    reg s2_ena;
    //assign en[0] = ena;
    assign s2_ena = (ena) ? ((q[3:0]==4'h9)?1'b1:1'b0) : 1'b0;
    decade_counter #(.N(10)) dut2(clk, reset,    ena, q[3:0]);
    decade_counter #(.N(6))  dut3(clk, reset, s2_ena, q[7:4]);
    
    assign m_ena = (q==8'h59)?1'b1:1'b0;
endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module decade_counter #(parameter N=10) (
    input clk,
    input reset,        // Synchronous active-high reset
    input en,
    output [3:0]q
);
    initial q=0;
    always @(posedge clk) begin
        if(reset) q<=0;
        else begin
            if (en) begin
                if (q==(N-1)) q<=0;
            	else q<=q+1;
        	end
        end
    end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);
    reg m_ena, h_ena, pm_ena;
    //reg [3:0]s_reset_value, m_reset_value, h_reset_value;
    //assign s_reset_value = 4'd0;
    //assign m_reset_value = 4'd0;
    //_60s_counter s(clk, reset, ena, ss, m_ena);
    //_60m_counter m(clk, reset, m_ena, mm, h_ena);
    hrs_counter h(clk, reset, ena, hh, mm, ss, pm_ena);
    always @(posedge clk) begin
        pm = (reset) ? 1'b0 : (pm_ena==1? ~pm : pm);
    end
endmodule
//==========================================hrs============================================================
module hrs_counter(
    input clk,
    input reset,
    input enable,
    output [7:0]q,
    output [7:0]mm,
    output [7:0]ss,
    output end_ena
);
    reg h_ena;
    min_counter m(clk, reset, enable, mm, ss, h_ena);
    initial q=8'h12;
    always @(posedge clk) begin
        if(reset) q<=8'h12;
        else begin
            if (h_ena) begin
                if (q==8'h09) q<=8'h10;
                else if (q==8'h12) q<=8'h00;
                else q[3:0]<=q[3:0]+4'b0001;
                //end_ena = (q==8'h11)?1'b1:1'b0;
        	end
        end
    end
    //assign end_ena = (q==8'h11)?1'b1:1'b0;
    assign end_ena = (h_ena)? ((q==8'h59)?1'b1:1'b0) : 1'b0;
endmodule
//======================================================mins========================================================
module min_counter(
    input clk,
    input reset,
    input enable,
    output [7:0]q,
    output [7:0]ss,
    output end_ena
);
    reg m_ena;
    reg [1:0]en;
    sec_counter s(clk, reset, enable, ss, m_ena);
    assign en[0] = m_ena;
    assign en[1] = (q[3:0]==9)?1'b1:1'b0;
    initial q=0;
    always @(posedge clk) begin
        if(reset) q<=0;
        else begin
            if (en[0]) begin
                if (q[3:0]==9) begin 
                    q[3:0]<=0;
                    //en[1]<=1;
                end
                else begin
                    q[3:0]<=q[3:0]+1;
                    //en[1]<=0;
                end
        	end
            if (en[1]) begin
                if (q[7:4]==4'h5) begin
                    q<=8'h0;
                	//end_ena<=1'b1;
                end
                else begin 
                    q[7:4]<=q[7:4]+1;
                    //end_ena<=1'b0;
                end
        	end
        end
    end
    assign end_ena = (en[1])? ((q==8'h59)?1'b1:1'b0) : 1'b0;
endmodule
//===================================================sec=============================================================
module sec_counter(
    input clk,
    input reset,
    input enable,
    output [7:0]q,
    output end_ena
);
    reg [1:0]en;
    assign en[0] = enable;
    assign en[1] = (q[3:0]==9)?1'b1:1'b0;
    initial q=0;
    always @(posedge clk) begin
        if(reset) q<=0;
        else begin
            if (en[0]) begin
                if (q[3:0]==9) begin 
                    q[3:0]<=0;
                    //en[1]<=1;
                end
                else begin
                    q[3:0]<=q[3:0]+1;
                    //en[1]<=0;
                end
        	end
            if (en[1]) begin
                if (q[7:4]==4'h5) begin
                    q<=8'h0;
                	//end_ena<=1'b1;
                end
                else begin 
                    q[7:4]<=q[7:4]+1;
                    //end_ena<=1'b0;
                end
        	end
        end
    end
    assign end_ena = (en[1])? ((q==8'h59)?1'b1:1'b0) : 1'b0;
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////
module decade_counter #(parameter N=10) (
    input clk,
    input reset,        // Synchronous active-high reset
    input en,
    output [3:0] q
);
    initial q=0;
    always @(posedge clk) begin
        if(reset) q<=0;
        else begin
            if (en) begin
                if (q==(N-1)) q<=0;
            	else q<=q+1;
        	end
        end
    end
endmodule
*/
