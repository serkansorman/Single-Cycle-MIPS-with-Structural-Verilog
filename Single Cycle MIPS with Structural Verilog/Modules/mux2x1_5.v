module mux2x1_5(out,a,b,s);
input [4:0] a,b;
input s;
output[4:0] out;

mux2x1 mu1(out[0],a[0],b[0],s);
mux2x1 mu2(out[1],a[1],b[1],s);
mux2x1 mu3(out[2],a[2],b[2],s);
mux2x1 mu4(out[3],a[3],b[3],s);
mux2x1 mu5(out[4],a[4],b[4],s);

endmodule