
`ifndef ALTERA_DEVICE_FAMILY
	`define ALTERA_DEVICE_FAMILY "Cyclone V"
`endif

module generic_sram_line_en_dualport #(
		parameter reg[7:0]      DATA_WIDTH = 8'd128,
		parameter reg[7:0]      ADDRESS_WIDTH = 8'd7,
		parameter DEVICE_FAMILY=`ALTERA_DEVICE_FAMILY
		) (
		input                           i_clk,
		input [DATA_WIDTH-1:0]          i_write_data_a,
		input                           i_write_enable_a,
		input [ADDRESS_WIDTH-1:0]       i_address_a,
		output [DATA_WIDTH-1:0]         o_read_data_a,
		
		input [DATA_WIDTH-1:0]          i_write_data_b,
		input                           i_write_enable_b,
		input [ADDRESS_WIDTH-1:0]       i_address_b,
		output [DATA_WIDTH-1:0]         o_read_data_b
		);
	
		parameter READ_DATA_REGISTERED = 1;

        altsyncram  #(
        		.byte_size(8),
        		.address_reg_b("CLOCK0"),
        		.clock_enable_input_a("BYPASS"),
        		.clock_enable_output_a("BYPASS"),
        		.clock_enable_input_b("BYPASS"),
        		.clock_enable_output_b("BYPASS"),
        		.intended_device_family(DEVICE_FAMILY),
        		.lpm_hint("ENABLE_RUNTIME_MOD=NO"),
        		.lpm_type("altsyncram"),
        		.numwords_a((1 << ADDRESS_WIDTH)),
        		.numwords_b((1 << ADDRESS_WIDTH)),
        		.operation_mode("BIDIR_DUAL_PORT"),
        		.outdata_aclr_a("NONE"),
        		.outdata_aclr_b("NONE"),
        		.outdata_reg_a((READ_DATA_REGISTERED)?"CLOCK0":"UNREGISTERED"),
        		.outdata_reg_b((READ_DATA_REGISTERED)?"CLOCK0":"UNREGISTERED"),
        		.power_up_uninitialized("FALSE"),
        		.read_during_write_mode_mixed_ports("DONT_CARE"),
        		.read_during_write_mode_port_a("NEW_DATA_NO_NBE_READ"),
        		.read_during_write_mode_port_b("NEW_DATA_NO_NBE_READ"),
        		.widthad_a(ADDRESS_WIDTH),
        		.widthad_b(ADDRESS_WIDTH),
        		.width_a(DATA_WIDTH),
        		.width_b(DATA_WIDTH),
        		.width_byteena_a(1),
        		.width_byteena_b(1),
        		.wrcontrol_wraddress_reg_b("CLOCK0")
        	) u_altram (
				.address_a (i_address_a),
                .address_b (i_address_b),
                .clock0 (i_clk),
                .data_a (i_write_data_a),
                .data_b (i_write_data_b),
                .wren_a (i_write_enable_a),
                .wren_b (i_write_enable_b),
                .q_a (o_read_data_a),
                .q_b (o_read_data_b),
                .aclr0 (1'b0),
                .aclr1 (1'b0),
                .addressstall_a (1'b0),
                .addressstall_b (1'b0),
				.byteena_a (1'b1),
                .byteena_b (1'b1),
                .clock1 (1'b1),
                .clocken0 (1'b1),
                .clocken1 (1'b1),
                .clocken2 (1'b1),
                .clocken3 (1'b1),
                .eccstatus (),
                .rden_a (1'b1),
                .rden_b (1'b1)
                );

endmodule

	