module data_memory (read_data, mem_address, write_data, sig_mem_read, sig_mem_write);
output reg [31:0] read_data;
input [31:0] mem_address;
input [31:0] write_data;
input sig_mem_read;
input sig_mem_write;

reg [31:0] data_mem  [255:0];

//reads the data from file
initial begin
	$readmemh(".\\data.mem", data_mem);
end


//if read signal is equal to 1, read data from memory
always @(mem_address or sig_mem_read)begin
	if (sig_mem_read) begin
		read_data[31:0] = data_mem[mem_address];
	end
end



//if write signal is equal to 1,write data to memory
always @(mem_address or write_data  or sig_mem_write) begin
	if (sig_mem_write) begin
		data_mem[mem_address] = write_data[31:0];
		$writememh("data.mem", data_mem);
	end
end

endmodule