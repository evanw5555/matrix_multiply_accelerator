module mac_controller(
    input clk,
    input reset,
    input enable,
    input [7:0] a [0:3][0:3],
    input [7:0] b [0:3][0:3],

    output reg [7:0] mac_ina [0:3][0:3],
    output reg [7:0] mac_inb [0:3][0:3],
    output reg done,
    output start

);
    assign start = (count==0);
    reg [1:0] count;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            done <= 0;
        end else if (enable) begin
            if (count == 'd3) begin
                done <= 1;
            end else begin
                done <=0;
            end
            count <= count + 1;
        end
    end


    genvar row;
    genvar col;
    generate
        for (row=0; row<4; row=row+1) begin : igen
            for (col=0; col<4; col=col+1) begin : iigen
                always @(*) begin
                    mac_ina[row][col] <= a[row][count];
                    mac_inb[row][col] <= b[count][col];
                end
            end
        end
    endgenerate

endmodule