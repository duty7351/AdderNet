`include "Parameter.v"
module CXOR
(
   output        o_xor, 
   input         i_a,
   input         i_b
);

//    assign o_xor = i_a ^ i_b;
//XOR2_X1M_A9TR xor_lib (.Y(o_xor), .A(i_a), .B(i_b));
xor xor0 ( o_xor, i_a, i_b );
endmodule
/*

module CXOR
(
   output    [`NBIT-1:0]    o_xor, 
   input     [`NBIT-1:0]    i_a,
   input     [`NBIT-1:0]    i_b
);

genvar i;
for (i=0; i<`NBIT; i=i+1) begin: gen_CXNOR_xor
    assign o_xor[`NBIT-1-i] = i_a[`NBIT-1-i] ^ i_b[`NBIT-1-i];
end

endmodule
*/
