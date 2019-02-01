module mux4x1_32(out,i0,i1,i2,i3,s1,s0);
input [31:0] i0,i1,i2,i3;
input s1,s0;
output [31:0] out;
wire [31:0]w1,w2;
mux2x1_32 mux_1(w1,i0,i1,s0);
mux2x1_32 mux_2(w2,i2,i3,s0);
mux2x1_32 mux_3(out,w1,w2,s1);
endmodule