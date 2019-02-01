module control_unit(
op_code,sign_reg_dest,
sign_branch,sign_mem_read,
sign_mem_to_reg,sign_mem_write,
sign_ALUsrc,sign_reg_write,sign_ALUop,sign_jump);

input [5:0] op_code;
output sign_reg_dest,sign_branch,sign_mem_read,sign_mem_to_reg,sign_mem_write,sign_reg_write,sign_jump;
output [1:0] sign_ALUsrc;
output [2:0] sign_ALUop;

wire w1,w2,w3,w4,w5,w6,w7,w8,w9;

//reg destination
not(w1,op_code[3]);
not(w2,op_code[1]);
and(sign_reg_dest,w1,w2);

//mem to reg
buf(sign_mem_to_reg,op_code[1]);

//reg write
not(w3,op_code[2]);
and(w4,w2,w3);
and(w5,w2,op_code[3]);
and(w6,w1,op_code[5]);
or(sign_reg_write,w4,w5,w6);

//mem read
and(sign_mem_read,w1,op_code[5]);

//mem write
and(sign_mem_write,op_code[3],op_code[1]);

//branch
and(sign_branch,w1,op_code[2]);

//jump
not(w7,op_code[0]);
and(sign_jump,w7,op_code[1]);

//ALUsrc
and(sign_ALUsrc[1],op_code[3],op_code[2]);
and(sign_ALUsrc[0],w3,op_code[0]);

//ALUop
and(sign_ALUop[2],w1,op_code[2]);
buf(sign_ALUop[1],w3);
and(w8,w3,w7);
and(w9,op_code[2],op_code[0]);
or(sign_ALUop[0],w8,w9);

endmodule