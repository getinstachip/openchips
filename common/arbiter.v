module arbiter #( parameter N    = 1,
		     ) 
   (
    input [N-1:0]  requests, //request vector
    output [N-1:0] grants    //grant (one hot)
    );

   wire [N-1:0]   waitmask; 
   genvar 	  j;     
   generate       
	begin : arbiter_fixed
	   assign waitmask[0]   = 1'b0;      
	   for (j=N-1; j>=1; j=j-1) 
	     begin : gen_arbiter     
		assign waitmask[j] = |requests[j-1:0];
	     end
	end
   endgenerate
      
   //grant circuit
   assign grants[N-1:0] = requests[N-1:0] & ~waitmask[N-1:0];
   
endmodule