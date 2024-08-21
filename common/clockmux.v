module clockmux #(parameter N    = 1)    // number of clock inputs
   (
    input [N-1:0] en, // one hot enable vector (needs to be stable!)
    input [N-1:0] clkin,// one hot clock inputs (only one is active!) 
    output 	  clkout 
    );

    generate
	 begin : generic
	    assign clkout = |(clkin[N-1:0] & en[N-1:0]);
	 end
    endgenerate   
endmodule // clockmux