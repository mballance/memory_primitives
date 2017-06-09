/****************************************************************************
 * generic_sram_byte_en_w.sv
 ****************************************************************************/

/**
 * Module: generic_sram_byte_en_w
 * 
 * TODO: Add module documentation
 */
module generic_sram_byte_en_w #(
		parameter int			MEM_ADDR_BITS=10,
		parameter int			MEM_DATA_BITS=32,
		parameter				INIT_FILE=""
		) (
			input							i_clk,
			generic_sram_byte_en_if.sram	s
		);

	// VL doesn't like direct assignments from the modport
	// to the sram instance
	wire [MEM_DATA_BITS-1:0] write_data;
	wire [MEM_DATA_BITS-1:0] read_data;
	wire write_en;
	wire [MEM_ADDR_BITS-1:0] address;
	wire [MEM_DATA_BITS/8-1:0]	byte_en;
	
	assign write_data = s.write_data;
	assign write_en = s.write_en;
	assign address = s.addr;
	assign s.read_data = read_data;
	assign byte_en = s.byte_en;
	
    generic_sram_byte_en #(
    	.DATA_WIDTH      (MEM_DATA_BITS  ), 
    	.ADDRESS_WIDTH   (MEM_ADDR_BITS  ),
    	.INIT_FILE       (INIT_FILE      )
    	) ram (
    	.i_clk           (i_clk         ), 
    	.i_write_data    (write_data    ),
    	.i_write_enable  (write_en      ), 
    	.i_address       (address       ),
    	.i_byte_enable   (byte_en     	),
    	.o_read_data     (read_data		)
    	);

endmodule

