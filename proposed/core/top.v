`include "Parameter.v"

module top
(
    input                       CLK,
    input   [`NBIT*`NDATA-1:0]  i_if,i_w,
    output  [`NRESULT:0]        o_result

   // output  [`NBIT*`NDATA-1:0] DFFKT_out_if,
   // output [`NBIT*`NDATA-1:0] DFFKT_out_w,
   // output [`NBIT*`NDATA-1:0] KT_out_w,
   // output  [`NDATA-1:0]    KT_out_sign,
   // output  [`NRESULT:0]    AT_out_r
);

wire    [`NBIT*`NDATA-1:0]    DFFKT_out_if, DFFKT_out_w;
wire    [`NBIT*`NDATA-1:0]    KT_out_r;
wire    [`NDATA-1:0]          KT_out_sign;

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
    .o_r(KT_out_r), .o_sign(KT_out_sign)
);

Adder_tree Adder_tree
(
    .i_data(KT_out_r), .i_sign(KT_out_sign),
    .o_result(AT_out_r)
);

DFF_Adder_tree DFF_Adder_tree
(
    .CLK(CLK),
    .i_r(AT_out_r),
    .o_r(o_result)
);

endmodule
