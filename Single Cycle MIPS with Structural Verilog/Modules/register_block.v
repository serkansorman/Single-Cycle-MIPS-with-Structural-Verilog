module register_block(read_data_1 , read_data_2 , write_data , read_reg_1 ,read_reg_2 , write_reg , signal_reg_write ,  clk);

	output reg [31:0] read_data_1, read_data_2;
	input [31:0] write_data;
	input [4:0] read_reg_1, read_reg_2, write_reg;
	input signal_reg_write, clk;
	
	reg [31:0] registers [31:0];
	
	//initially reads registers
	initial begin
		$readmemh(".\\registers.mem", registers);
	end
	
	//Reads rs and rt content from registers according to read_reg_1 and read_reg_2
	always @(*)begin
		read_data_1 = registers[read_reg_1];
		read_data_2 = registers[read_reg_2];
	end
	
	//Writes data to write register.
	always @(posedge clk)  
	begin // Can not write to R0,R26,R27,R28,R29,R30,R31
		if (signal_reg_write && write_reg != 5'b0 && write_reg != 5'b11010 && write_reg != 5'b11011
		&& write_reg != 5'b11100&& write_reg != 5'b11101&& write_reg != 5'b11110&& write_reg != 5'b11111) begin
			registers[write_reg] = write_data;
			$writememh("registers.mem", registers);
		end
	end
endmodule