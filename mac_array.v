module mac_array (
    input clk,
    input reset,
    input enable,
    input [7:0] a [0:3][0:3],
    input [7:0] b [0:3][0:3],
    output done,
    output [31:0] c [0:3][0:3]
);
    wire [7:0] mac_ina [0:3][0:3];
    wire [7:0] mac_inb [0:3][0:3];
    wire start;

    mac_controller mc (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .a(a),
        .b(b),

        .mac_ina(mac_ina),
        .mac_inb(mac_inb),
        .done(done),
        .start(start)
    );

    genvar row;
    genvar col;
    generate
        for(row=0; row<4; row=row+1) begin : mac
            for(col=0; col<4; col=col+1) begin : mac2
                mac_unit u_mac(
                    .a(mac_ina[row][col]),
                    .b(mac_inb[row][col]),
                    .enable(enable),
                    .clk(clk),
                    .reset(reset),
                    .acc(c[row][col]),
                    .start(start)
                );
            end
        end
    endgenerate
endmodule