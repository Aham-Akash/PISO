module PISO_tb #(parameter n = 4) ();
	reg i_clk;
	reg i_rst;
	reg i_load;
	reg [n-1:0] i_parallel_in;
	wire o_serial_out;
	
	PISO DUT (.i_clk(i_clk), .i_rst(i_rst), .i_load(i_load), .i_parallel_in(i_parallel_in), .o_serial_out(o_serial_out));
	
	initial begin
		i_clk = 1'b0;
		forever #5 i_clk = ~i_clk;	//100M Hz clock
	end
	
	initial begin
		i_rst = 1'b1; 
		i_parallel_in = 4'b1010; 
		i_load = 1'b0;
		#10 i_rst = 1'b0; 
		#5 i_load = 1'b1;
		#10 i_load = 1'b0;
		#100 $finish;
	end

endmodule 