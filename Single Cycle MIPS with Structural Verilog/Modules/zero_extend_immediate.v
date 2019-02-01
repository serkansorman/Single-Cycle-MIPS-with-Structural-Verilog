module zero_extend_immediate(immediate, result);

input [15:0]immediate;
output [31:0] result;

buf (result[0],immediate[0]);
buf (result[1],immediate[1]);
buf (result[2],immediate[2]);
buf (result[3],immediate[3]);
buf (result[4],immediate[4]);
buf (result[5],immediate[5]);
buf (result[6],immediate[6]);
buf (result[7],immediate[7]);
buf (result[8],immediate[8]);
buf (result[9],immediate[9]);
buf (result[10],immediate[10]);
buf (result[11],immediate[11]);
buf (result[12],immediate[12]);
buf (result[13],immediate[13]);
buf (result[14],immediate[14]);
buf (result[15],immediate[15]);
buf (result[16],1'b0);
buf (result[17],1'b0);
buf (result[18],1'b0);
buf (result[19],1'b0);
buf (result[20],1'b0);
buf (result[21],1'b0);
buf (result[22],1'b0);
buf (result[23],1'b0);
buf (result[24],1'b0);
buf (result[25],1'b0);
buf (result[26],1'b0);
buf (result[27],1'b0);
buf (result[28],1'b0);
buf (result[29],1'b0);
buf (result[30],1'b0);
buf (result[31],1'b0);

endmodule