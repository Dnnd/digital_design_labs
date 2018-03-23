//command bit definitions
import cmd_bits::*;

module dev_fsm
#(
	// parameter declaration
	parameter DW = 8	// data width
)
(
	// inputs
	input logic clk, rst, cs,
	input logic [DW - 1:0] din,

	// outputs
	output logic busy, drdy,
	output logic [DW - 1:0] dout
);
	
	// state register and next state value
	enum logic [4:0] {ST_IDLE, ST_RCV_1, ST_RCV_2, ST_PROC, ST_TX} state, next_state;
	
	// data and status registers
	logic [DW - 1:0] result;
	logic [DW - 1:0] op_1;
	logic [DW - 1:0] op_2;
	logic [DW - 1:0] cmd;
	
	// state register
	always_ff @ (posedge clk or negedge rst)
	begin
		if (~rst) state <= ST_IDLE;
		else state <= next_state;
	end

   	//next state logic
	always_comb
	begin    
		case (state)
		ST_IDLE:
			if(cs)
			begin
				if(din[b_tx])
					next_state = ST_TX;
				else 
					next_state = ST_RCV_1;
			end					
		ST_RCV_1:			
			next_state = ST_RCV_2;
		ST_RCV_2:
			next_state = ST_PROC;
		ST_PROC:		
			next_state = ST_IDLE;
		ST_TX:
			next_state = ST_IDLE;
		default:
			next_state = ST_IDLE;
		endcase
	end

	// data and status registers
	always_ff @ (posedge clk or negedge rst)
	begin
		if (~rst)
		begin
			drdy <= 0;
			busy <= 0;
			result <= 0;
			op_1 <= 0;
			op_2 <= 0;
			cmd <= 0;
		end
		else
		begin
			//we set busy to 0 at reset and when we enter idle
						
			busy <= !(next_state==ST_IDLE);
			drdy <= (next_state == ST_TX);	
			
			//latching data in registers
			case (state)
				ST_IDLE:
				begin
					//store command in register when we leave idle
					if (cs) cmd <= din;
				end		
				ST_RCV_1:
					//store operand 1
					op_1<=din;
				ST_RCV_2:
					//store operand 2
					op_2<=din;
				ST_PROC:
					//change result register according to opcode
					case (cmd[DW - 1:DW - 4])
						4'b1000: result <= op_1 + op_2;
						4'b0100: result <= op_1 - op_2;
						4'b0010: result <= result + op_1;
						4'b0001: result <= result - op_1;
					endcase
			endcase
		end
	end

	assign dout = (state==ST_TX)?result:'bx;
	
endmodule
