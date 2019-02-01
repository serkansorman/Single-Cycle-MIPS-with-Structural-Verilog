module instr_memory(instruction, PC);
input [31:0] PC;
output reg[31:0] instruction;

//Depends on number of instruction in file
reg [31:0] instr_mem [31:0];

//reads the instructions.
initial begin
	$readmemh(".\\instruction.mem", instr_mem);
end

//Reads instruction according to current PC
always @(*) begin
	instruction = instr_mem[PC];
end
endmodule