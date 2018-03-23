module counter_tb;

logic clk, clrn, vec;
logic [2:0] q_fsm, q_rc;

counter_rc c_rc (vec, clrn, clk, q_rc);
counter_fsm c_fsm(vec, clrn, clk, q_fsm);

integer clk_count;

initial
begin
	clk = 0;
	q_fsm = 0;
	q_rc = 0;
	forever #10 clk = ~clk;
end

initial
begin
	clrn = 0;
	vec = 0;		
	repeat(4)@(negedge clk);
	clrn = 1;

	//Счет вниз
	repeat(16)@(negedge clk);
	
	//Счет вверх с нечетного числа
	wait(q_fsm == 1 || q_rc == 1);
	@(negedge clk) vec = 1;		
	repeat(16)@(negedge clk);
		
	//Счет вниз до четного числа
	@(negedge clk) vec = 0;	
	wait(q_fsm == 0 || q_rc == 0);
	
	//Счет вверх с четного числа
	@(negedge clk) vec = 1;		
	repeat(16)@(negedge clk);
	
	$finish;
end

initial
begin
	clk_count = 0;
	forever@(posedge clk) clk_count <= clk_count + 1;
end	

initial
begin		
	forever@(negedge clk)
	begin
		$strobe("clk_num: %d, counter_rc: %d, counter_fsm:%d, vec: %d", clk_count, q_rc, q_fsm, vec);
	end		
end

endmodule