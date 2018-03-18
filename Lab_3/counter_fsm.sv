module counter_fsm(
	input logic vec, clrn, clk,
	output logic [2:0] q
);

enum logic [2:0] {S0, S1, S2, S3, S4, S5, S6, S7} state, next_state;

always_ff@(posedge clk or negedge clrn)
begin
	if(!clrn)
		state <= S0;
	else
		state <= next_state;
end		

always_comb
begin
	case(state)
	S0: 
		if(vec)
			next_state = S2;
		else	
			next_state = S7;
	S1:	
		if(vec)
			next_state = S3;
		else	
			next_state = S0;
	S2:		
		if(vec)
			next_state = S4;
		else	
			next_state = S1;
	S3:		
		if(vec)
			next_state = S5;
		else	
			next_state = S2;
	S4:		
		if(vec)
			next_state = S6;
		else	
			next_state = S3;
	S5:		
		if(vec)
			next_state = S7;
		else	
			next_state = S4;		
	S6:		
		if(vec)
			next_state = S0;
		else	
			next_state = S5;
	S7:		
		if(vec)
			next_state = S1;
		else	
			next_state = S6;
	endcase		
end

always@(state)
begin
	case(state)
		S0: q = 3'b000;
		S1: q = 3'b001;
		S2: q = 3'b010;
		S3: q = 3'b011;
		S4: q = 3'b100;
		S5: q = 3'b101;
		S6: q = 3'b110;
		S7: q = 3'b111;
		default: q = 3'b000;
	endcase
end
endmodule