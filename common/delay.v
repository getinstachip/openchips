module delay  #(parameter DW   = 1, // width of data
		   parameter DELAY= 0  // delay
		   )   
   (
    input [DW-1:0]  in, // input 
    output [DW-1:0] out // output
    );
   
   generate
        #DELAY
	   assign out[DW-1:0] = in [DW-1:0];
   endgenerate
    
endmodule // delay