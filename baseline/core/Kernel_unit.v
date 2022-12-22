// Origin AdderNet thesis Kernel version

`include "Parameter.v"

module Kernel_unit
(
   input    [`NBIT-1:0]    i_if,
   input    [`NBIT-1:0]    i_w,
   output   [`NBIT-1:0]    o_result
);

wire [`NBIT-1:0] SUB_if_w;
wire [`NBIT-1:0] SUB_w_if;

wire MSB;

assign SUB_if_w = i_if - i_w;
assign SUB_w_if = i_w - i_if;

assign MSB = SUB_if_w[`NBIT-1];

assign o_result = MSB ? SUB_w_if : SUB_if_w;

endmodule
