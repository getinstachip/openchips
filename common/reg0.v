module reg0 #(parameter DW = 1            // data width
		  ) 
   ( input           nreset, //async active low reset
     input 	     clk, // clk, latch when clk=0
     input [DW-1:0]  in, // input data
     output [DW-1:0] out  // output data (stable/latched when clk=1)
     );

   generate
	begin
	   reg [DW-1:0] out_reg;	   
	   always @ (negedge clk or negedge nreset)
	     if(~nreset)
	       out_reg[DW-1:0] <= 'b0;
	     else	      
	       out_reg[DW-1:0] <= in[DW-1:0];
	   assign out[DW-1:0] = out_reg[DW-1:0];	   
	end
   endgenerate
   
endmodule // reg0