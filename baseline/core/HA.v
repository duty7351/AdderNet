module HA
(   
    input   a, b,
    output  cout, s
);

assign cout = a&b;
assign s = a^b;

endmodule

