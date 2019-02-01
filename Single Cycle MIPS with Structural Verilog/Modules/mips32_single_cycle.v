module mips32_single_cycle(clock);

input clock;
wire [31:0] instruction;
wire [31:0] rs_content, rt_content, firstALUInput,secondALUInput,tempSecondInput;
wire [31:0] PC;
wire [4:0] rs, rt, rd, shamt,write_reg;
wire [5:0] op_code, func_field;
wire [31:0] result,extended_shamt, R,sltu_result,zero_extended_immediate,sign_extended_immediate,read_data,jump_address;
wire [15:0] immediate;
wire sign_reg_dest,sign_branch,sign_mem_read,sign_mem_to_reg,sign_mem_write,sign_reg_write,sign_jump;
wire [1:0] sign_ALUsrc;
wire [2:0] sign_ALUop;
wire [31:0] write_data;
wire [2:0] Op;
wire zero_bit,select_branch,select_shift,select_sltu,temp;

//Get instruction from instruction memory, using PC 
instr_memory im(instruction,PC);

//Opcode
buf (op_code[0], instruction[26]);
buf (op_code[1], instruction[27]);
buf (op_code[2], instruction[28]);
buf (op_code[3], instruction[29]);
buf (op_code[4], instruction[30]);
buf (op_code[5], instruction[31]);
//rs
buf (rs[0], instruction[21]);
buf (rs[1], instruction[22]);
buf (rs[2], instruction[23]);
buf (rs[3], instruction[24]);
buf (rs[4], instruction[25]);
//rt
buf (rt[0], instruction[16]);
buf (rt[1], instruction[17]);
buf (rt[2], instruction[18]);
buf (rt[3], instruction[19]);
buf (rt[4], instruction[20]);
//rd
buf (rd[0], instruction[11]);
buf (rd[1], instruction[12]);
buf (rd[2], instruction[13]);
buf (rd[3], instruction[14]);
buf (rd[4], instruction[15]);
//shamt
buf (shamt[0], instruction[6]);
buf (shamt[1], instruction[7]);
buf (shamt[2], instruction[8]);
buf (shamt[3], instruction[9]);
buf (shamt[4], instruction[10]);
//function code
buf (func_field[0], instruction[0]);
buf (func_field[1], instruction[1]);
buf (func_field[2], instruction[2]);
buf (func_field[3], instruction[3]);
buf (func_field[4], instruction[4]);
buf (func_field[5], instruction[5]);

//immediate
buf (immediate[0], instruction[0]);
buf (immediate[1], instruction[1]);
buf (immediate[2], instruction[2]);
buf (immediate[3], instruction[3]);
buf (immediate[4], instruction[4]);
buf (immediate[5], instruction[5]);
buf (immediate[6], instruction[6]);
buf (immediate[7], instruction[7]);
buf (immediate[8], instruction[8]);
buf (immediate[9], instruction[9]);
buf (immediate[10], instruction[10]);
buf (immediate[11], instruction[11]);
buf (immediate[12], instruction[12]);
buf (immediate[13], instruction[13]);
buf (immediate[14], instruction[14]);
buf (immediate[15], instruction[15]);

//jump_address
buf (jump_address[0], instruction[0]);
buf (jump_address[1], instruction[1]);
buf (jump_address[2], instruction[2]);
buf (jump_address[3], instruction[3]);
buf (jump_address[4], instruction[4]);
buf (jump_address[5], instruction[5]);
buf (jump_address[6], instruction[6]);
buf (jump_address[7], instruction[7]);
buf (jump_address[8], instruction[8]);
buf (jump_address[9], instruction[9]);
buf (jump_address[10], instruction[10]);
buf (jump_address[11], instruction[11]);
buf (jump_address[12], instruction[12]);
buf (jump_address[13], instruction[13]);
buf (jump_address[14], instruction[14]);
buf (jump_address[15], instruction[15]);
buf (jump_address[16], instruction[16]);
buf (jump_address[17], instruction[17]);
buf (jump_address[18], instruction[18]);
buf (jump_address[19], instruction[19]);
buf (jump_address[20], instruction[20]);
buf (jump_address[21], instruction[21]);
buf (jump_address[22], instruction[22]);
buf (jump_address[23], instruction[23]);
buf (jump_address[24], instruction[24]);
buf (jump_address[25], instruction[25]);
buf (jump_address[26], 1'b0);
buf (jump_address[27], 1'b0);
buf (jump_address[28], PC[28]);
buf (jump_address[29], PC[29]);
buf (jump_address[30], PC[30]);
buf (jump_address[31], PC[31]);


//Get signals from control unit according to op code 
control_unit cu(op_code,sign_reg_dest,sign_branch,sign_mem_read,
sign_mem_to_reg,sign_mem_write,sign_ALUsrc,sign_reg_write,sign_ALUop,sign_jump);

//Select write register rt or rd according to reg dest signal
mux2x1_5 mux5(write_reg,rt,rd,sign_reg_dest);

//Get rs and rt contents or write data to register
register_block rb(rs_content,rt_content,write_data,rs,rt,write_reg,sign_reg_write,clock);

//Zero extend shamt, zero extend immediate and sign extend immediate
zero_extend ze(shamt,extended_shamt);
zero_extend_immediate zei(immediate,zero_extended_immediate);
sign_extend se(immediate,sign_extended_immediate);

//select_shift is 0 if given instruction is shift instruction
or(select_shift,op_code[5],op_code[4],op_code[3],op_code[2],op_code[1],op_code[0],func_field[5]);

//Select rs or rt for first ALU input according to select_shift bit
mux2x1_32 firstInput(firstALUInput,rt_content,rs_content,select_shift);

//Select rt,sign_extended_immediate,zero_extended_immediate for second ALU input
mux4x1_32 secondTemp(tempSecondInput,rt_content,sign_extended_immediate,zero_extended_immediate,32'b0,sign_ALUsrc[1],sign_ALUsrc[0]);

//Select shamt for second ALU input, if instruction is shift
mux2x1_32 secondInput(secondALUInput,extended_shamt,tempSecondInput,select_shift);


// Get 3 bit op from alucontrol and compute result in alu according to op
alu_control u1(sign_ALUop,func_field, Op);
alu32 u2(R, firstALUInput, secondALUInput, Op, zero_bit);

//Select result for sltu instruction (0 or 1)
mux2x1_32 mu3(sltu_result,32'b0,32'b1,R[31]);
not(temp,func_field[3]);
//select_sltu is 0 if given instruction is sltu
or(select_sltu,op_code[5],op_code[4],op_code[3],op_code[2],op_code[1],op_code[0],temp);
mux2x1_32 mux_sltu(result,sltu_result,R,select_sltu);

//Get data from address to read_data(lw) or write rt_content to memory
data_memory dm(read_data,R,rt_content,sign_mem_read,sign_mem_write);
//Select R Type ALU result or lw result to write register
mux2x1_32 mm(write_data,result,read_data,sign_mem_to_reg);

// Check current instruction is branch
and(select_branch,zero_bit,sign_branch);

//update PC
next_PC npc(PC,sign_extended_immediate,jump_address,select_branch,sign_jump,clock);


//This behavioral block was only used to display the contents of the instruction on the screen.
initial begin
$monitor("Instruction: %8H, ALU Result : %8H, RS Content: %8H, RT Content: %8h, RegDest: %5b ,PC : %8H ,clock :%d",instruction,result,rs_content,rt_content,write_reg,PC,clock);
end

endmodule