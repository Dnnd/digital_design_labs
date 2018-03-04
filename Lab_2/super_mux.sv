module super_mux(
   input logic a, b,
   input logic [1:0] sel,
   output logic result
);

logic inv_b;

always_comb
   begin
		inv_b = ~b;
      case (sel)
         2'b00: result = ~(a & inv_b);
         2'b01: result = a & inv_b;
         2'b10: result = ~(a & inv_b);
         2'b11: result = a | inv_b;
      endcase
   end
   
endmodule
