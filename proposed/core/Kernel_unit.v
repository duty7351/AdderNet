`include "Parameter.v"

module Kernel_unit
(
   i_if, i_w,
   o_result, o_sign
);

input     [`NBIT-1:0]   i_if, i_w;
output    [`NBIT-1:0]   o_result;
output                  o_sign;

wire      [`NBIT-1:0]   SUB_if_w;
wire      [`NBIT-1:0]   EXT_MSB;

// modified 2022-09-01
//assign SUB_if_w = i_if - i_w;
CRCA CRCA ( .i_A(i_if), .i_B(i_w), .o_S(SUB_if_w) );

assign o_sign = SUB_if_w[`NBIT-1]; // extract only sign bit
assign EXT_MSB = {`NBIT{o_sign}};

genvar i;
generate for (i=0;i<`NBIT;i=i+1) begin: loop_cxor
    CXOR cxor ( .o_xor(o_result[i]), .i_a(EXT_MSB[i]), .i_b(SUB_if_w[i]));
end
endgenerate

endmodule
