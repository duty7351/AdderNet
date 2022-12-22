`include "Parameter.v"

module Kernel
(
    input    [`NBIT * `NDATA-1:0] i_if, i_w,
    output   [`NBIT * `NDATA-1:0] o_r,
    output   [`NDATA-1:0]         o_sign
);

genvar i;
generate
    for (i=0; i<`NDATA; i=i+1) begin: gen_Kernel
       Kernel_unit Kernel_unit
      (
          .i_if(i_if[`NBIT*i+:`NBIT]),
          .i_w(i_w[`NBIT*i+:`NBIT]), 
          .o_result(o_r[`NBIT*i+:`NBIT]), 
          .o_sign(o_sign[i])
       );  
    end 
endgenerate

endmodule
