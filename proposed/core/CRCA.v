`include "Parameter.v"

module CRCA
(
    input   [`NBIT-1:0]    i_A,
    input   [`NBIT-1:0]    i_B,
    output  [`NBIT-1:0]    o_S
);

wire [`NBIT-1:0] Src_B;
wire [`NBIT-1:0] Cout;

genvar i;

generate
    for (i=0; i<`NBIT; i=i+1) begin : loop_CRCA_cxor
        CXOR xor_lib (.o_xor(Src_B[i]), .i_a(i_B[i]), .i_b(1'b1));
    end
endgenerate

//for (i=0; i<`NBIT; i=i+1) begin : loop_CRCA_fa
//    if (i == 0)
//        ADDF_X1M_A9TR fa_lib (.CI(1'b1), .A(i_A[i]), .B(Src_B[i]), .S(o_S[i]), .CO(Cout[i]));
//    ADDF_X1M_A9TR fa_lib (.CI(Cout[i]), .A(i_A[i]), .B(Src_B[i]), .S(o_S[i]), .CO(Cout[i]));
//end

generate
    for (i=0; i<`NBIT; i=i+1) begin : loop_CRCA_fa
        if (i == 0)
            FA FA_CRCA ( .a(i_A[i]), .b(Src_B[i]), .cin(1'b1), .cout(Cout[i]), .s(o_S[i]) );
        else
            FA FA_CRCA ( .a(i_A[i]), .b(Src_B[i]), .cin(Cout[i-1]), .cout(Cout[i]), .s(o_S[i]) );
end
endgenerate

endmodule
