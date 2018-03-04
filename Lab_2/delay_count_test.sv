module delay_counter_test;

logic resetn;
logic clk;
logic [2:0] delay;
logic [3 :0] count;

delay_counter counter(resetn, clk, delay, count);

initial
	begin
		clk = 0;
		delay = 3;
		forever #10 clk = ~clk;
	end
initial
	begin
		resetn = 0;
		repeat(4)@(negedge clk);
		resetn = 1;
	end
	
initial
	begin
		#160 resetn = 0;
		#40 resetn = 1;
	end
	
initial 
	begin
		forever
			#5 $strobe("clk: %d, count: %d",clk, count);
	end

initial
		begin
			#1000 $finish;
		end
endmodule