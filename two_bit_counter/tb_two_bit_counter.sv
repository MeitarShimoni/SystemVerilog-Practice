

// also for practice 1, implementing a test bench for the 2-bit counter

//`timescale 1ns / 1ps
`include "two_bit_counter.sv"

module tb_two_bit_counter;

	// the testbench's signals:
	logic clk;
	logic reset;
	logic enable;
	logic [1:0] count_out;

	// instance to the design:
	two_bit_counter dut(
		.clk(clk),
		.reset(reset),
		.enable(enable),
		.count_out(count_out)
		);

	// all the initials and always blocks running in parallel.
	initial begin
		clk = 0; 
		forever #10 clk = ~clk;
	end

	initial begin
		$monitor("At time %t, reset = %b, enable = %b, count_out = %b.", $time, reset, enable, count_out);
		// here the sequence of the process.
		reset = 1;
		enable = 0;
		#20
		reset = 0;
		#10
		enable = 1;
		#100
		$display("Test finished.");
		$finish;

	end

endmodule 
