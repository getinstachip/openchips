module pulse2pulse (
		       input  nrstin, //input domain reset   
		       input  din, //input pulse (one clock cycle)
		       input  clkin, //input clock
		       input  nrstout, //output domain reset  
		       input  clkout, //output clock       
		       output dout    //output pulse (one clock cycle)
		       );
   
   // local wires
   reg toggle_reg;
   reg pulse_reg;
   wire toggle;
   
   
   //pulse to toggle
   assign toggle = din ? ~toggle_reg : toggle_reg;
   
   always @ (posedge clkin)
     if(~nrstin)
       toggle_reg <= 1'b0;
     else
       toggle_reg <= toggle;
      
   //metastability synchronizer
   dsync sync(.dout	(toggle_sync),
		 .din      (toggle),
		 .nreset   (nrstout), 
		 .clk      (clkout));

   //toogle to pulse
   always @ (posedge clkout)
     if(!nrstout)
       pulse_reg <= 1'b0;
     else
       pulse_reg <= toggle_sync;

   assign dout = pulse_reg ^ toggle_sync;
   
endmodule // pulse2pulse