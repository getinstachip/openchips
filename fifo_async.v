module fifo_async # (parameter DW        = 104,      // FIFO width
			parameter DEPTH     = 32,       // FIFO depth (entries)
			parameter PROG_FULL = (DEPTH/2),// program full threshold   
			parameter AW = $clog2(DEPTH)    // binary read count width
			)
   (
    input 	    nreset, // async reset
    input 	    wr_clk, // write clock   
    input 	    wr_en, // write fifo
    input [DW-1:0]  din, // data to write
    input 	    rd_clk, // read clock   
    input 	    rd_en, // read fifo
    output [DW-1:0] dout, // output data (next cycle)
    output 	    full, // fifo is full
    output 	    prog_full, // fifo reaches full threshold
    output 	    empty, // fifo is empty
    output [AW-1:0] rd_count  // # of valid entries in fifo
    );
      
   //local wires
   wire [AW-1:0]   wr_count;  // valid entries in fifo

   generate
     begin : basic   
	 fifo_generic #(.DEPTH(DEPTH),
			   .DW(DW))
	 fifo_generic (
		       // Outputs
		       .full			(full),
		       .prog_full		(prog_full),
		       .dout			(dout[DW-1:0]),
		       .empty			(empty),
		       .rd_count		(rd_count[AW-1:0]),
		       .wr_count		(wr_count[AW-1:0]),
		       // Inputs
		       .nreset   		(nreset),
		       .wr_clk			(wr_clk),
		       .rd_clk			(rd_clk),
		       .wr_en			(wr_en),
		       .din			(din[DW-1:0]),
		       .rd_en			(rd_en));
      end 
   endgenerate
      
endmodule // fifo_async