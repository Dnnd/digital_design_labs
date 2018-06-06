`timescale 1 ps/ 1 ps

//command bit definitions
import cmd_bits::*;

module dev_fsm_tb();

	//parameters
	parameter DW = 8;

	// test vector input registers
	logic clk;
	logic cs;
	logic [DW-1:0] din;
	logic rst;
	// module output connections
	logic busy;
	logic [DW-1:0] dout;
	logic drdy;
	// testbench variables
	logic [DW-1:0] res;

    //device under test
	dev_fsm #(.DW(DW)) dut (
		.busy(busy),
		.clk(clk),
		.cs(cs),
		.din(din),
		.dout(dout),
		.drdy(drdy),
		.rst(rst)
	);

	// create clock
	initial                                                
	begin                                                  
		clk=0;
		forever #10 clk=~clk;
	end                                                    

	// reset circuit and run several transactions
	initial
	begin
		// reset
		rst=0;
		@(negedge clk) rst=1;
		//skip one edge after reset
		@(posedge clk);
	
		write_transaction((1<<b_op_1)|(1<<b_op_2)|(1<<b_addop), $random, $random,res);
					
		read_result(res);
	
		write_transaction((1<<b_op_1)|(1<<b_addres),$random,0,res);
		read_result(res);
		read_result(res);

		//wait couple clock cycles
		repeat (2) @(posedge clk);
		//stop simulation
		$stop;
	end
	
	task read_result;
		output [DW-1:0] result;
		begin 
			while(busy)@(posedge clk);
			cs = 1;	
			din = (1 << b_tx);			
			@(posedge clk);
			cs = 0;		
			while(!drdy) @(posedge clk);	
			result = dout;
			@(posedge clk);
		end	
	endtask
		
	//basic transaction with module
	task write_transaction;
		//input signals
		input [DW-1:0] cmd;
		input [DW-1:0] op_1;
		input [DW-1:0] op_2;
		output [DW-1:0] result;
		//transaction implementation
		begin
			//wait while device is busy
			while (busy) @(posedge clk);
			//set chip select and write command to DUT
			cs=1;						
			din=cmd;
			
			
			//clear chip select
			@(posedge clk);
			cs=0;
			//write op_1 if required and wait for one clock cycle
			
			din=op_1;
			@(posedge clk);
			
			//write op_2 if required and wait for one clock cycle
			din=op_2;
			@(posedge clk);	
			
		end
	endtask
	
endmodule

