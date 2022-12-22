`include "Parameter.v"

module DFF_Kernel
(
    input                       CLK,
    input   [`NBIT*`NDATA-1:0]  i_if, i_w,
    output  [`NBIT*`NDATA-1:0]  o_if, o_w
);

reg [`NBIT-1:0] reg_if [`NDATA-1:0];
reg [`NBIT-1:0] reg_w [`NDATA-1:0];

genvar i;
for (i=0; i<`NDATA; i=i+1) begin : gen_assign
    assign o_if[`NBIT*i+:`NBIT] = reg_if[i];
    assign o_w [`NBIT*i+:`NBIT] = reg_w[i];
end

integer j;
always @ (posedge CLK) begin
    for (j=0; j<`NDATA; j=j+1) begin
       reg_if[j] <= i_if[`NBIT*j+:`NBIT];
       reg_w [j] <= i_w [`NBIT*j+:`NBIT];
    end
end
endmodule
