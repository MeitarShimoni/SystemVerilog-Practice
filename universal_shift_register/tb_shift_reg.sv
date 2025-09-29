

`include "shift_reg.sv"

module tb_shift_reg;

	logic clk;
	logic reset;
	logic [1:0] mode;
	logic [3:0] p_in;
	logic s_in;
	logic [3:0] q_out;
	logic is_zero;

lab2_shift_reg dut ( 
	.clk(clk),
	.reset(reset),
	.mode(mode),
	.p_in(p_in),
	.s_in(s_in),
	.q_out(q_out),
	.is_zero(is_zero)
	);

initial begin
	clk = 0;
	forever #10 clk = ~ clk;
end

initial begin

	$monitor("Time: %t | clk: %b, reset: %b, mode: %b, p_in: %h, s_in: %b | q_out: %h, is_zero: %b",
             $time, clk, reset, mode, p_in, s_in, q_out, is_zero);
	reset = 1;
	mode = 2'b00; //HOLD
	p_in = 4'hx;
	s_in = 4'hX;
	@(posedge clk)
	@(posedge clk)
	reset = 0;
	@(negedge clk)
	p_in = 4'b1010;
	mode = 2'b11; // LOAD
	@(posedge clk)
	@(posedge clk)

	if (q_out == p_in) begin
		$display("NEW data (%b) is at the shift register",q_out);
	end
	else begin
		$display("Failed!");
	end

	    // --- Test Shift Right (mode 10) ---
    @(posedge clk);
    mode = 2'b10; // Set to shift right mode
    s_in = 1'b1;  // We will shift a '1' in
    @(posedge clk); // DUT shifts on this edge. Expected: {1, 101} -> 1101
    @(posedge clk); // Shift again. Expected: {1, 110} -> 1110
    
    // --- Test Shift Left (mode 01) ---

    @(posedge clk);
    $display("SHIFT");
    mode = 2'b01; // Set to shift left mode
    s_in = 1'b0;  // We will shift a '0' in
    @(posedge clk); // DUT shifts on this edge. Expected: {110, 0} -> 1100
    @(posedge clk); // Shift again. Expected: {100, 0} -> 1000

    // --- Test Hold (mode 00) ---
    @(posedge clk);
    $display("HOLD");
    mode = 2'b00; // Set to hold mode
    @(posedge clk); // q_out should not change
    @(posedge clk); // q_out should still not change

    #50;
    $display("Test Finished.");
    $finish;


end









endmodule
