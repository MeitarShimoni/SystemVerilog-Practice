

module shift_reg (
	input logic clk,
	input logic reset,
	input logic [1:0] mode,
	input logic [3:0] p_in,
	input logic s_in,
	output logic [3:0] q_out,
	output logic is_zero);

// TODO 1: implement the entire shift reg

always_ff @(posedge clk) begin
	if (reset) begin
		q_out <= 4'b0000;
	end
	else begin
		
		case (mode)
			2'b00: q_out <= q_out; // Hold
			2'b01: q_out <= {q_out[2:0], s_in};  //shift left
			2'b10: q_out <= {s_in, q_out[3:1]}; // Shift Right
			2'b11: q_out <= p_in;
		endcase
	end
end

// TODO 2: implement the is zero combinational.

always_comb begin

if (q_out == 4'd0) begin
	is_zero = 1'b1;
end
else begin
	is_zero = 1'b0;
end
	
end


endmodule 
