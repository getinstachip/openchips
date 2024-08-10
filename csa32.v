module csa32 #(parameter DW   = 1 // data width
		  )
   ( input [DW-1:0]  in0, //input
     input [DW-1:0]  in1,//input
     input [DW-1:0]  in2,//input
     output [DW-1:0] s, //sum 
     output [DW-1:0] c   //carry
     );

   generate
	begin : generic
	   assign s[DW-1:0] = in0[DW-1:0] ^ in1[DW-1:0] ^ in2[DW-1:0];
	   assign c[DW-1:0] = (in0[DW-1:0] & in1[DW-1:0]) | 
			      (in1[DW-1:0] & in2[DW-1:0]) | 
			      (in2[DW-1:0] & in0[DW-1:0] );
	end
   endgenerate
   
endmodule