`define NBIT 16
`define NDATA 64
`define NRESULT 22

module tb_top;

reg CLK;
reg signed [`NBIT*`NDATA-1:0] i_if, i_w;
wire signed [`NRESULT:0] result;

top uut 
( 
    .CLK(CLK),
    .i_if(i_if), .i_w(i_w),
    .o_result(result)
);

always #5 CLK = ~CLK;

integer i, sum;

initial begin
//    $sdf_annotate("/data/gwanghwiseo/EDA/EDA_AdderNet/syn/results/top.sdf",uut, , , "MAXIMUM");
//    $shm_open("wave.shm");
//    $shm_probe(uut, "AS");
CLK = 1;
sum = 0;
i_if = 0;
i_w = 0;

#100;

i_if[0*`NBIT+:`NBIT] <= 16'd4;
i_w[0*`NBIT+:`NBIT]  <= 16'd5;

i_if[1*`NBIT+:`NBIT] <= 16'd7;
i_w[1*`NBIT+:`NBIT]  <= 16'd1;

i_if[2*`NBIT+:`NBIT] <= 16'd2;
i_w[2*`NBIT+:`NBIT]  <= 16'd3;

i_if[3*`NBIT+:`NBIT] <= 16'd1;
i_w[3*`NBIT+:`NBIT]  <= 16'd0;
#100;
i_if[4*`NBIT+:`NBIT] <= 16'd7;
i_w[4*`NBIT+:`NBIT]  <= 16'd5;

i_if[5*`NBIT+:`NBIT] <= 16'd12;
i_w[5*`NBIT+:`NBIT]  <= 16'd1;

i_if[6*`NBIT+:`NBIT] <= 16'd1;
i_w[6*`NBIT+:`NBIT]  <= 16'd3;

i_if[7*`NBIT+:`NBIT] <= 16'd8;
i_w[7*`NBIT+:`NBIT]  <= 16'd0;

#100;
for (i = 0; i < 8; i = i+1) begin
    if (i_if[i*`NBIT+:`NBIT] < i_w[i*`NBIT+:`NBIT]) begin
            $display("if < weight\n");
            sum = sum + i_w[i*`NBIT+:`NBIT] - i_if[i*`NBIT+:`NBIT];
        end
    else if (i % 4 == 0) begin
        $display("SUM: %d", sum);
        sum = 0; 
    end
    else begin
        sum = sum + i_if[i*`NBIT+:`NBIT] - i_w[i*`NBIT+:`NBIT];
        $display("if > weight\n");
    end
end
$display("sum %d", sum);
//for (i = 0; i < `NDATA; i = i+1) begin
//for (i = 0; i < 4; i = i+1) begin
//    if ($signed(i_if[i*`NBIT+:`NBIT]) < $signed(i_w[i*`NBIT+:`NBIT])) begin
//            $display("if < weight\n");
//            sum = sum + $signed((i_w[i*`NBIT+:`NBIT])) - $signed((i_if[i*`NBIT+:`NBIT]));
//        end
//            sum = sum + $signed((i_if[i*`NBIT+:`NBIT])) - $signed((i_w[i*`NBIT+:`NBIT]));
//            $display("if > weight\n");
//        end
//end
#100;
//    $shm_close;
    $finish;
end
endmodule
