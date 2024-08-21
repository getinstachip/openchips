module clockor #(parameter N    = 1)    // number of clock inputs
   (
    input [N-1:0] clkin,// one hot clock inputs (only one is active!) 
    output 	  clkout 
    );

   generate
	begin : generic
	   assign clkout = |(clkin[N-1:0]);
	end
   endgenerate   
endmodule // clockmux