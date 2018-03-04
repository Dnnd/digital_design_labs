module decode_shift 
#(parameter WIDTH = 3) 
(input logic [WIDTH-1:0] din, output logic [2**WIDTH-1:0] dout); 
 
 always_comb dout=1<<din; 
 
endmodule 