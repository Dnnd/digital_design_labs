module tff_reg(
	input logic data, clk, reset,
	output logic q
);

	always_ff @(posedge clk or negedge reset)
		if (~reset) q <= 1'b0;
		else if (data) q <= ~q;

endmodule
