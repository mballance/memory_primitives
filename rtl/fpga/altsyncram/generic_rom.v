/****************************************************************************
 * generic_rom.v
 * 
 * Wrapper around the altsyncram primitive
 ****************************************************************************/

`ifndef ALTERA_DEVICE_FAMILY
	`define ALTERA_DEVICE_FAMILY "Cyclone V"
`endif

module generic_rom #(
		parameter DATA_WIDTH = 32,
		parameter ADDRESS_WIDTH = 32,
		parameter INIT_FILE = "file.mem",
		parameter DEVICE_FAMILY=`ALTERA_DEVICE_FAMILY
		) (
		input                           i_clk,
		input [ADDRESS_WIDTH-1:0]       i_address,
		output [DATA_WIDTH-1:0]         o_read_data
		);

	wire[DATA_WIDTH-1:0]            read_data;

	assign o_read_data = read_data;

	altsyncram #(
			.address_aclr_a("NONE"),
			.clock_enable_input_a("BYPASS"),
			.clock_enable_output_a("BYPASS"),
			.init_file(INIT_FILE),
			.intended_device_family(DEVICE_FAMILY),
			.lpm_hint("ENABLE_RUNTIME_MOD=NO"),
			.lpm_type("altsyncram"),
			.numwords_a((1 << ADDRESS_WIDTH)),
			.operation_mode("ROM"),
			.outdata_aclr_a("NONE"),
			.outdata_reg_a("CLOCK0"),
			.widthad_a(ADDRESS_WIDTH),
			.width_a(DATA_WIDTH),
			.width_byteena_a(1)
		) u_altram (
			.address_a (i_address),
			.clock0 (i_clk),
			.q_a (read_data),
			.aclr0 (1'b0),
			.aclr1 (1'b0),
			.address_b (1'b1),
			.addressstall_a (1'b0),
			.addressstall_b (1'b0),
			.byteena_a (1'b1),
			.byteena_b (1'b1),
			.clock1 (1'b1),
			.clocken0 (1'b1),
			.clocken1 (1'b1),
			.clocken2 (1'b1),
			.clocken3 (1'b1),
			.data_a ({DATA_WIDTH{1'b1}}),
			.data_b (1'b1),
			.eccstatus (),
			.q_b (),
			.rden_a (1'b1),
			.rden_b (1'b1),
			.wren_a (1'b0),
			.wren_b (1'b0));

endmodule

