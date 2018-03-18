module counter_rc(
	input logic vec, clrn, clk,
	output logic [2:0] q
);

always_ff@(posedge clk or negedge clrn)
begin
	if(!clrn) q <= 0;
	else
	begin
		q[2] <= (q[2] & ~q[1] & vec)
					| (~q[2] & q[1] & vec)
					| (~q[2] & ~q[1] & ~q[0] & ~vec)
					| (q[2] & q[0] & ~vec)
					| (q[1] & ~vec & q[2]);
					
		q[1] <= (vec & ~q[1])
					|(~q[0] & ~q[1])
					|(~vec & q[0] & q[1]);
					
		q[0] <= (~vec & ~q[0])
					| (vec & q[0]);
	end	
end	

endmodule
