module delay_counter(
	input logic resetn,
	input logic clk,
	input logic [2:0] delay,
	output logic [3 :0] count
);
logic [2:0] clk_buffer;

always_ff@(posedge clk or negedge resetn)
	begin
		if(!resetn)
			begin			
				count <= 0;
				clk_buffer <= 0;
			end
		else
			begin				
				if(count == 15)
					begin

						if(clk_buffer == 0) count <= 0;
						else clk_buffer <= clk_buffer - 1;
					end	
				else if(clk_buffer == delay - 1)
					begin
						count <= count + 1;
					end
				else
					begin
						clk_buffer <= clk_buffer + 1;
					end
			end	
	end
endmodule		
		