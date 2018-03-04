`timescale 1ns/1ps

module super_mux_test;

logic a, b;
logic [1:0] sel;

logic test_result;
logic result;

assign ref_val = (sel == 2'b00) & (~(a & ~b)) | 
							(sel == 2'b01) & (a & ~b) | 
							(sel == 2'b10) & ( ~(a & ~b)) | 
							(sel == 2'b11) & ( a | ~b);
							
super_mux super_mux_test(a, b, sel, result);

initial
	begin
		for(int i = 0; i < 4; i++)
			begin
				#10 sel = i;
				for(int j = 0; j < 2; j++)
					begin
						#10 a = j;
						for(int k = 0; k < 2; k++)
							begin
										#10 b = k;
										#10 $strobe("a: %d, b: %d, sel : %b, result: %d, ref %d", a, b, sel, result, ref_val);
							end
					end
			end
	#10 $finish;			
	end
endmodule	