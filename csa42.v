module csa42 #( parameter DW    = 1 // data width
		   )
   ( input [DW-1:0]  in0, //input
     input [DW-1:0]  in1,//input
     input [DW-1:0]  in2,//input
     input [DW-1:0]  in3,//input
     input [DW-1:0]  cin,//carry in
     output [DW-1:0] s, //sum 
     output [DW-1:0] c, //carry
     output [DW-1:0] cout  //carry out
     );

   generate
	begin
	   wire [DW-1:0]     s_int;
	   
	   assign s[DW-1:0]  = in0[DW-1:0] ^ 
			       in1[DW-1:0] ^ 
			       in2[DW-1:0] ^ 
			       in3[DW-1:0] ^ 
			       cin[DW-1:0];
	   
	   assign s_int[DW-1:0] = in1[DW-1:0] ^ 
				  in2[DW-1:0] ^ 
				  in3[DW-1:0];
	   
	   assign c[DW-1:0]     = (in0[DW-1:0] & s_int[DW-1:0]) | 
				  (in0[DW-1:0] & cin[DW-1:0])   | 
				  (s_int[DW-1:0] & cin[DW-1:0]);
	   
	   assign cout[DW-1:0]  = (in1[DW-1:0] & in2[DW-1:0]) | 
				  (in1[DW-1:0] & in3[DW-1:0]) | 
				  (in2[DW-1:0] & in3[DW-1:0]);
	end
   endgenerate
   
endmodule