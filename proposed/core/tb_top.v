`include "Parameter.v"

module tb_top;

reg    signed	  [`NBIT*`NDATA-1:0]	IF, W;
reg				  CLK;
wire	[`NRESULT:0]	RESULT;

top uut ( .CLK(CLK), .i_if(IF), .i_w(W), .o_result(RESULT) );

always #5 CLK = ~CLK;

initial begin
	#10; CLK = 1'b1;
	#10; IF <= `NBIT'd3;
		 W <= `NBIT'd2;
	#10; IF <= `NBIT'd5;
		 W <= `NBIT'd7;
	#100; $finish;
end

endmodule
