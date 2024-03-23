module ram_char1 #(
	parameter DATA_WIDTH	= 8,
	parameter ADDR_WIDTH	= 8,
	parameter RAM_INIT_FILE	= "ram_init_file.inithex"
)(
	input  [(ADDR_WIDTH-1):0] raddr,
	output [(DATA_WIDTH-1):0] rdata
);

localparam MEMORY_DEPTH = 2**ADDR_WIDTH;
localparam MAX_DATA = (1<<ADDR_WIDTH)-1;

reg [DATA_WIDTH-1:0] ram[MEMORY_DEPTH-1:0];
assign rdata = ram[raddr];

initial
begin
	if (RAM_INIT_FILE != "")
		$readmemh(RAM_INIT_FILE, ram);
end

endmodule
