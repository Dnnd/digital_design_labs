//установим временную сетку 
`timescale 1ns/1ps 
 
module decode_test; 
localparam WIDTH = 4; 
 
logic [WIDTH-1:0] enc_data; 
logic [2**WIDTH-1:0] dec_data; 
 
initial 
begin 
//начинаем перебор значений с нуля 
 enc_data=0; 
repeat (2**WIDTH) 
	begin 
	 $strobe("Input value: %d; output value: %b; time: %d", enc_data, dec_data, $time); 
	  #10 enc_data=enc_data+1; 
	end 
$finish; 
end 
 
decode_shift #(WIDTH) uut_inst(enc_data,dec_data); 
 
endmodule 