module mips_testbench ();
	
	reg clock;
	reg [7:0] index;

	always 
	begin
			#50 clock = ~clock;
	end
	
	initial begin
		clock = 0;
		index = 0;
	end
	
	mips32_single_cycle test(clock);
	

	always @(posedge clock) 
	begin
		
		index <= index + 1;
		
		if(index == 8'd17)//Depends on number of instructions that executed
		begin
			$finish;
		end
	end
		
		
endmodule
