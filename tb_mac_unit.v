`timescale 1ns/1ps

module tb_mac_unit();
    reg clk;
    reg enable;
    reg reset;
    reg signed [7:0] a;
    reg signed [7:0] b;
    wire signed [31:0] acc;

    mac_unit uut (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .a(a),
        .b(b),
        .acc(acc)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        enable = 0;
        a = 0;
        b = 0;

        // Hold reset for 10 ns
        #10 reset = 0;

        // Enable the MAC
        enable = 1;

        // Apply inputs
        #10 a = -5; b = 5;
        #10 a = 1; b = 3;
        #10 a = 5; b = 4;
        #10 a = 2; b = 6;

        #10 $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_mac_unit);
    end
endmodule
