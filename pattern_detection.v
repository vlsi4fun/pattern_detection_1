module pattern_detection
(
	input clk_i,
	input reset_i,
	input data_i,
	output match_o
);

parameter IDLE 	= 2'd0;
parameter S1	= 2'd1;
parameter S10	= 2'd2;
parameter S101	= 2'd3;

reg [1:0]next_state;
reg [1:0]curr_state;

always@(posedge clk_i or negedge reset_i)
begin
	if(!reset_i)
	curr_state <= 2'd0;
	else
	curr_state <= next_state;
end

always@ *
begin
match = 1'd0;
next_state = IDLE;
case (curr_state)
	IDLE: 
	begin
		if(data_i)
		next_state = S1;
	end
	S1: 
	begin
		if(data_i)
		next_state = S1;
		else
		next_state = S10;
	end
	S10: 
	begin
		if(data_i)
		next_state = S101;
	end
	S101: 
	begin
		if(data_i)
		next_state = S1;
		else
		next_state = S10;
	end	
endcase
end

assign match = (curr_state == S101) ? 1'd1:1'd0; 
