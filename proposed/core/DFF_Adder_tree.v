`include "Parameter.v"

module DFF_Adder_tree
(
    input   CLK, 
    input   [`NRESULT:0]    i_r,
    output  [`NRESULT:0]    o_r 
);
//reg [`NRESULT:0] r_r;

//for (i=0; i<`NRESULT+1; i=i+1) begin
//    assign o_r[i] = r_r[i];
//end

//genvar i;
//generate
//    for (i=0; i<`NRESULT+1; i=i+1) begin
//        DFFQ_X1M_A9TR DFFQ_lib (.D(i_r[i]), .CK(CLK), .Q(o_r[i]));
//    end
//endgenerate

CDFF #(`NRESULT+1) DFF_AT ( .CLK(CLK), .D(i_r), .Q(o_r) );

//integer j;
//always @ (posedge CLK) begin
//    // Samsung FF 
//    for (j=0; j<`NRESULT+1; j=j+1)
//        r_r[j] <= i_r[j];
//    end

//generate
//    always @ (posedge CLK) begin
//        for (i=0; i<`NRESULT+1; i=i+1)
//            r_r[i] <= i_r[i];
//    end
//endgenerate

//always @ (posedge CLK) begin
//    r_r <= i_r;
//end


endmodule
