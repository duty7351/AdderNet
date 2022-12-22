// Origin AdderNet

`include "Parameter.v"

module top
(
    input                       CLK,
    input   [`NBIT*`NDATA-1:0]  i_if,i_w,
    output  [`NRESULT:0]        o_result
);

wire    [`NBIT*`NDATA-1:0]    DFFKT_out_if, DFFKT_out_w;
wire    [`NBIT*`NDATA-1:0]    KT_out_r;

wire    [`NRESULT:0]        AT_out_r;

DFF_Kernel DFF_Kernel
(  
    .CLK(CLK),
    .i_if(i_if), .i_w(i_w),
    .o_if(DFFKT_out_if), .o_w(DFFKT_out_w)
);

Kernel Kernel
(
    .i_if(DFFKT_out_if), .i_w(DFFKT_out_w),
    .o_r(KT_out_r)
);


Adder_tree Adder_tree
(
    .i_data(KT_out_r), .o_result(AT_out_r)
);

DFF_Adder_tree DFF_Adder_tree
(
    .CLK(CLK),
    .i_r(AT_out_r),
    .o_r(o_result)
);

endmodule
