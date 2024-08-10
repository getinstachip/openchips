module csa92 #( parameter DW    = 1) // data width

   ( input [DW-1:0]  in0, //input
     input [DW-1:0]  in1,//input
     input [DW-1:0]  in2,//input
     input [DW-1:0]  in3,//input
     input [DW-1:0]  in4,//input
     input [DW-1:0]  in5,//input
     input [DW-1:0]  in6,//input
     input [DW-1:0]  in7,//input
     input [DW-1:0]  in8,//input
     input [DW-1:0]  cin0,//carry in
     input [DW-1:0]  cin1,//carry in
     input [DW-1:0]  cin2,//carry in
     input [DW-1:0]  cin3,//carry in
     input [DW-1:0]  cin4,//carry in
     input [DW-1:0]  cin5,//carry in
     output [DW-1:0] s, //sum 
     output [DW-1:0] c, //carry
     output [DW-1:0] cout0, //carry out
     output [DW-1:0] cout1, //carry out
     output [DW-1:0] cout2, //carry out
     output [DW-1:0] cout3, //carry out
     output [DW-1:0] cout4, //carry out
     output [DW-1:0] cout5  //carry out
     );


   wire [DW-1:0]     s_int0;
   wire [DW-1:0]     s_int1;
   wire [DW-1:0]     s_int2;

   csa32 #(.DW(DW)) csa32_0 (.in0(in0[DW-1:0]),
				.in1(in1[DW-1:0]),
				.in2(in2[DW-1:0]),
				.c(cout0[DW-1:0]),
				.s(s_int0[DW-1:0]));

   csa32 #(.DW(DW)) csa32_1 (.in0(in3[DW-1:0]),
				.in1(in4[DW-1:0]),
				.in2(in5[DW-1:0]),
				.c(cout1[DW-1:0]),
				.s(s_int1[DW-1:0]));

   csa32 #(.DW(DW)) csa32_2 (.in0(in6[DW-1:0]),
				.in1(in7[DW-1:0]),
				.in2(in8[DW-1:0]),
				.c(cout2[DW-1:0]),
				.s(s_int2[DW-1:0]));
   
   csa62 #(.DW(DW)) csa62 (.in0(s_int0[DW-1:0]),   
			      .in1(s_int1[DW-1:0]),   
			      .in2(s_int2[DW-1:0]),
			      .in3(cin0[DW-1:0]),    
			      .in4(cin1[DW-1:0]),    
			      .in5(cin2[DW-1:0]),
			      .cin0(cin3[DW-1:0]),  
			      .cin1(cin4[DW-1:0]),  
			      .cin2(cin5[DW-1:0]),
			      .cout0(cout3[DW-1:0]),
			      .cout1(cout4[DW-1:0]),
			      .cout2(cout5[DW-1:0]),
			      .c(c[DW-1:0]),
			      .s(s[DW-1:0]));

endmodule // csa92