module alu_control(alu_op,func_field,op);

input [5:0] func_field;
input [2:0] alu_op;
output [2:0] op;

wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14;

not (w1,func_field[5]);
and (w2,w1,alu_op[1],alu_op[0]);
and(w3,func_field[1],alu_op[1],alu_op[0]);
or(op[2],w2,w3,alu_op[2]);


not(w4,func_field[2]);
not(w5,func_field[1]);
and(w6,w4,w5,alu_op[1]);

not(w7,alu_op[0]);
and(w8,w7,alu_op[1]);

and(w9,func_field[2],func_field[1],alu_op[1]);
or(op[1],w6,w8,w9);

not(w10,alu_op[1]);
and(w11,w10,alu_op[0]);

not(w12,func_field[5]);
and(w13,w12,func_field[1],alu_op[0]);

and(w14,func_field[2],func_field[0],alu_op[0]);
or(op[0],w11,w13,w14);


endmodule

