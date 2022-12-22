//module CDFF #(parameter WIDTH=32) (CK,D,Q); 
//input CK; 
//input [WIDTH-1:0] D;
//output reg [WIDTH-1:0] Q;
//
//always @ (posedge CK) begin
//    Q <= D;
//end
//
//endmodule
//

module CDFF #(parameter WIDTH=16) 
(
    input CLK,
    input [WIDTH-1:0] D,
    output reg [WIDTH-1:0] Q
);

always @ (posedge CLK) begin
	Q <= D;
end


//genvar i;
//generate
//    for (i=0; i<WIDTH; i=i+1) begin
//        DFF DFF ( .D(D[i]), .CLK(CLK) ,.Q(Q[i]) );
//    end
//endgenerate

endmodule

