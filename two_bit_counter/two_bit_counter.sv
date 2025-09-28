//`timescale 1ns / 1ps

// Practice 1, implementing a 2-bit counter.

module two_bit_counter (
	input logic clk,
	input logic reset,
	input logic enable,
	output logic [1:0] count_out
	);


// The counter logic here.
always_ff @(posedge clk) begin
	if (reset) begin
		count_out <= 2'b00;
	end
	else if (enable) begin
		count_out <= count_out + 1;
	end
end
endmodule
