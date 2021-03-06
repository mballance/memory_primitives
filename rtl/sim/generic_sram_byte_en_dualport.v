//////////////////////////////////////////////////////////////////
//                                                              //
//  Generic Library SRAM with per byte write enable             //
//                                                              //
//  This file is part of the Amber project                      //
//  http://www.opencores.org/project,amber                      //
//                                                              //
//  Description                                                 //
//  Configurable depth and width. The DATA_WIDTH must be a      //
//  multiple of 8.                                              //
//                                                              //
//  Author(s):                                                  //
//      - Conor Santifort, csantifort.amber@gmail.com           //
//                                                              //
//////////////////////////////////////////////////////////////////
//                                                              //
// Copyright (C) 2010 Authors and OPENCORES.ORG                 //
//                                                              //
// This source file may be used and distributed without         //
// restriction provided that this copyright statement is not    //
// removed from the file and that any derivative work contains  //
// the original copyright notice and the associated disclaimer. //
//                                                              //
// This source file is free software; you can redistribute it   //
// and/or modify it under the terms of the GNU Lesser General   //
// Public License as published by the Free Software Foundation; //
// either version 2.1 of the License, or (at your option) any   //
// later version.                                               //
//                                                              //
// This source is distributed in the hope that it will be       //
// useful, but WITHOUT ANY WARRANTY; without even the implied   //
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      //
// PURPOSE.  See the GNU Lesser General Public License for more //
// details.                                                     //
//                                                              //
// You should have received a copy of the GNU Lesser General    //
// Public License along with this source; if not, download it   //
// from http://www.opencores.org/lgpl.shtml                     //
//                                                              //
//////////////////////////////////////////////////////////////////


module generic_sram_byte_en_dualport #(
	parameter DATA_WIDTH    = 128,
	parameter ADDRESS_WIDTH = 7,
	parameter INIT_FILE = ""
	) (
	input                           i_clk,
	
	input      [DATA_WIDTH-1:0]     i_write_data_a,
	input                           i_write_enable_a,
	input      [ADDRESS_WIDTH-1:0]  i_address_a,
	input      [DATA_WIDTH/8-1:0]   i_byte_enable_a,
	output     [DATA_WIDTH-1:0]     o_read_data_a,
	
	input      [DATA_WIDTH-1:0]     i_write_data_b,
	input                           i_write_enable_b,
	input      [ADDRESS_WIDTH-1:0]  i_address_b,
	input      [DATA_WIDTH/8-1:0]   i_byte_enable_b,
	output     [DATA_WIDTH-1:0]     o_read_data_b
    );                                                     

	reg [DATA_WIDTH-1:0]   mem  [0:2**ADDRESS_WIDTH-1];
	
	initial begin
		if (INIT_FILE != "") begin
			$display("Initializing SRAM %m from %s", INIT_FILE);
			$readmemh(INIT_FILE, mem);
		end
	end
	
	// read
	assign o_read_data_a = i_write_enable_a ? {DATA_WIDTH{1'd0}} : mem[i_address_a];
//	genvar j;

//	generate
//	genvar i;
//	integer i;
	always @(posedge i_clk) begin : WRITE
		integer i;

		// write
			for (i=0;i<DATA_WIDTH/8;i=i+1) begin : mw
				if (i_write_enable_a) begin
				mem[i_address_a][i*8+0] = i_byte_enable_a[i] ? i_write_data_a[i*8+0] : mem[i_address_a][i*8+0] ;
				mem[i_address_a][i*8+1] = i_byte_enable_a[i] ? i_write_data_a[i*8+1] : mem[i_address_a][i*8+1] ;
				mem[i_address_a][i*8+2] = i_byte_enable_a[i] ? i_write_data_a[i*8+2] : mem[i_address_a][i*8+2] ;
				mem[i_address_a][i*8+3] = i_byte_enable_a[i] ? i_write_data_a[i*8+3] : mem[i_address_a][i*8+3] ;
				mem[i_address_a][i*8+4] = i_byte_enable_a[i] ? i_write_data_a[i*8+4] : mem[i_address_a][i*8+4] ;
				mem[i_address_a][i*8+5] = i_byte_enable_a[i] ? i_write_data_a[i*8+5] : mem[i_address_a][i*8+5] ;
				mem[i_address_a][i*8+6] = i_byte_enable_a[i] ? i_write_data_a[i*8+6] : mem[i_address_a][i*8+6] ;
				mem[i_address_a][i*8+7] = i_byte_enable_a[i] ? i_write_data_a[i*8+7] : mem[i_address_a][i*8+7] ;
				end
			end
    end
//	 endgenerate
    
   	assign o_read_data_b = i_write_enable_b ? 
		{DATA_WIDTH{1'd0}} : 
		mem[i_address_b];

	 generate
	integer j;
    always @(posedge i_clk) begin
    	// read

    	// write
    	if (i_write_enable_b) begin
    		for (j=0;j<DATA_WIDTH/8;j=j+1) begin
    			mem[i_address_b][j*8+0] = i_byte_enable_b[j] ? i_write_data_b[j*8+0] : mem[i_address_b][j*8+0] ;
    			mem[i_address_b][j*8+1] = i_byte_enable_b[j] ? i_write_data_b[j*8+1] : mem[i_address_b][j*8+1] ;
    			mem[i_address_b][j*8+2] = i_byte_enable_b[j] ? i_write_data_b[j*8+2] : mem[i_address_b][j*8+2] ;
    			mem[i_address_b][j*8+3] = i_byte_enable_b[j] ? i_write_data_b[j*8+3] : mem[i_address_b][j*8+3] ;
    			mem[i_address_b][j*8+4] = i_byte_enable_b[j] ? i_write_data_b[j*8+4] : mem[i_address_b][j*8+4] ;
    			mem[i_address_b][j*8+5] = i_byte_enable_b[j] ? i_write_data_b[j*8+5] : mem[i_address_b][j*8+5] ;
    			mem[i_address_b][j*8+6] = i_byte_enable_b[j] ? i_write_data_b[j*8+6] : mem[i_address_b][j*8+6] ;
    			mem[i_address_b][j*8+7] = i_byte_enable_b[j] ? i_write_data_b[j*8+7] : mem[i_address_b][j*8+7] ;
    		end
    	end
    end
	 endgenerate
    

endmodule

