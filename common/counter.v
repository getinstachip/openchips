module counter #(
    parameter DW   = 32,         // width of data inputs
    parameter TYPE = "INCREMENT" // also DECREMENT
) (
    input clk,    // clk input
    input in,     // input to count
    input en,     // enable counter
    input load,   // load counter
    input [DW-1:0] load_data, // load data
    output reg [DW-1:0] count, // current count value
    output reg carry, // carry out from counter
    output zero   // counter is zero
);

    wire [DW:0] count_in;

    // configure counter based on type
    generate
        if(TYPE=="INCREMENT")
            assign count_in = {1'b0, count} + in;
        else if(TYPE=="DECREMENT")
            assign count_in = {1'b0, count} - in;
    endgenerate

    // counter
    always @(posedge clk) begin
        if (load) begin
            carry <= 1'b0;
            count <= load_data;
        end
        else if (en) begin
            carry <= count_in[DW];
            count <= count_in[DW-1:0];
        end
    end

    // counter expired
    assign zero = (count == {DW{1'b0}});

endmodule