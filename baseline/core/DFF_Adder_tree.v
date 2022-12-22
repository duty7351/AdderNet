`include "Parameter.v"

module DFF_Adder_tree
(
    input   CLK, 
    input   [`NRESULT:0]    i_r,
    output  [`NRESULT:0]    o_r 
);
reg [`NRESULT:0] r_r;
assign o_r = r_r;

always @ (posedge CLK) begin
    r_r <= i_r;

end
endmodule
