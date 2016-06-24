
`ifndef ALTERA_DEVICE_FAMILY
	`define ALTERA_DEVICE_FAMILY "Cyclone V"
`endif

module generic_sram_line_en #(
		parameter reg[7:0]      DATA_WIDTH = 8'd128,
		parameter reg[7:0]      ADDRESS_WIDTH = 8'd7,
		parameter DEVICE_FAMILY=`ALTERA_DEVICE_FAMILY
		) (
		input                           i_clk,
		input [DATA_WIDTH-1:0]          i_write_data,
		input                           i_write_enable,
		input [ADDRESS_WIDTH-1:0]       i_address,
		output [DATA_WIDTH-1:0]         o_read_data);
	
		parameter READ_DATA_REGISTERED = 1;

        altsyncram  #(
        		.byte_size(8),
        		.clock_enable_input_a("BYPASS"),
        		.clock_enable_output_a("BYPASS"),
        		.intended_device_family(DEVICE_FAMILY),
        		.lpm_hint("ENABLE_RUNTIME_MOD=NO"),
        		.lpm_type("altsyncram"),
        		.numwords_a((1 << ADDRESS_WIDTH)),
        		.operation_mode("SINGLE_PORT"),
        		.outdata_aclr_a("NONE"),
        		.outdata_reg_a((READ_DATA_REGISTERED)?"CLOCK0":"UNREGISTERED"),
        		.power_up_uninitialized("FALSE"),
        		.read_during_write_mode_port_a("NEW_DATA_NO_NBE_READ"),
        		.widthad_a(ADDRESS_WIDTH),
        		.width_a(DATA_WIDTH),
        		.width_byteena_a(1)
        	) u_altram (
				.address_a (i_address),
                .byteena_a (1'b1),
                .clock0 (i_clk),
                .data_a (i_write_data),
                .wren_a (i_write_enable),
                .q_a (o_read_data),
                .aclr0 (1'b0),
                .aclr1 (1'b0),
                .address_b (1'b1),
                .addressstall_a (1'b0),
                .addressstall_b (1'b0),
                .byteena_b (1'b1),
                .clock1 (1'b1),
                .clocken0 (1'b1),
                .clocken1 (1'b1),
                .clocken2 (1'b1),
                .clocken3 (1'b1),
                .data_b (1'b1),
                .eccstatus (),
                .q_b (),
                .rden_a (1'b1),
                .rden_b (1'b1),
                .wren_b (1'b0));

endmodule

	