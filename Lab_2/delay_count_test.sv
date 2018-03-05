module delay_counter_test;

logic resetn;
logic clk;
logic [2:0] delay;
logic [3 :0] count;

delay_counter counter(resetn, clk, delay, count);

integer clk_count;

initial
begin
	clk = 0;
	delay = 3;
	clk_count = 0;
	forever #10 clk = ~clk;
end


initial
begin
	forever @(posedge clk) clk_count = clk_count + 1;
end
	
	
initial
begin
	resetn = 0;
	repeat(4)@(negedge clk);
	resetn = 1;
end
	
initial
begin
	#256 resetn = 0;
	#64 resetn = 1;
end
	
initial 
begin	
	forever@(negedge clk)
	begin
		if(resetn) $strobe("count: %d, clk_count: %d", count, clk_count); 
	end	
end

initial
begin
	#2048 $finish;
end
endmodule