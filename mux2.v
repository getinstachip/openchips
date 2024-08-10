module mux2 #(parameter DW = 1 ) // width of mux
   (
    input 	    sel1,
    input 	    sel0,
    input [DW-1:0]  in1,
    input [DW-1:0]  in0, 
    output [DW-1:0] out  //selected data output
    );
   
   assign out[DW-1:0] = ({(DW){sel0}} & in0[DW-1:0] |
			 {(DW){sel1}} & in1[DW-1:0]);
   
			   
endmodule // mux2