`timescale 1ns/1ps

module tb_mac_array ();
    reg clk;
    reg reset;
    reg enable;
    reg [7:0] a [0:3][0:3];
    reg [7:0] b [0:3][0:3];
    wire done;
    wire [31:0] c [0:3][0:3];

    mac_array uut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .a(a),
    .b(b),
    .done(done),
    .c(c)
);
    always #5 clk = ~clk;

    initial begin
        clk=0;
        enable = 0;
        reset = 1;
        // Matrix A
        a[0][0] = 8'd5;   a[0][1] = 8'd2;   a[0][2] = 8'd7;   a[0][3] = 8'd1;
        a[1][0] = 8'd3;   a[1][1] = 8'd6;   a[1][2] = 8'd4;   a[1][3] = 8'd8;
        a[2][0] = 8'd9;   a[2][1] = 8'd0;   a[2][2] = 8'd2;   a[2][3] = 8'd5;
        a[3][0] = 8'd1;   a[3][1] = 8'd3;   a[3][2] = 8'd8;   a[3][3] = 8'd6;

        // Matrix B 67
        b[0][0] = 8'd2;   b[0][1] = 8'd7;   b[0][2] = 8'd1;   b[0][3] = 8'd4;
        b[1][0] = 8'd5;   b[1][1] = 8'd0;   b[1][2] = 8'd6;   b[1][3] = 8'd3;
        b[2][0] = 8'd3;   b[2][1] = 8'd8;   b[2][2] = 8'd2;   b[2][3] = 8'd1;
        b[3][0] = 8'd4;   b[3][1] = 8'd1;   b[3][2] = 8'd9;   b[3][3] = 8'd5;



        #10
        reset = 0;
        enable = 1;

        #1000 $finish;
    end
    integer i, j;

    task display_matrix;
    begin
        $display("Time = %0t", $time);
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1)
                $write("%8d ", c[i][j]);
            $write("\n");
        end
    end
    endtask

    always @(posedge done) begin
        display_matrix();
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_mac_array);
    end

endmodule