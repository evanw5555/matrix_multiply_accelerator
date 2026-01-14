module mac_unit(
    input [7:0] a,
    input [7:0] b,
    input enable,
    input clk,
    input reset,
    input start,
    output reg [31:0] acc
);
    wire signed [7:0] a_s = a;
    wire signed [7:0] b_s = b;
    wire signed [15:0] product;
    assign product = a_s * b_s;


    always @(posedge clk or posedge reset) begin
        if (reset) begin
            acc <= 0;
        end else if (enable) begin
            if (start) begin
                acc <= product;
            end else begin
                acc <= acc + product;
            end
        end
    end
endmodule