module FA
(
    input   a, b, cin, 
    output  cout, s
);

assign cout = a&b | b&cin | cin&a;

assign s = a^b^cin;

endmodule
