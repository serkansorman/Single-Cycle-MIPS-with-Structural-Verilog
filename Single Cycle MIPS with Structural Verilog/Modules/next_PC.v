module next_PC(PC,extended_immediate,jump_address,select_branch,sign_jump,clock);

input [31:0] extended_immediate;
input select_branch,sign_jump,clock;
input [31:0] jump_address;
output reg[31:0] PC;

//Initial PC is 0
initial PC = 32'b0;

always @(posedge clock)
begin
	
	if(sign_jump == 1) begin //Jump
		PC <= jump_address;
	end
	else if(select_branch == 1)begin // Branch
		 PC <= PC + 1 + extended_immediate;
	end
	else begin 
		PC <= PC + 1;
	end
end


endmodule