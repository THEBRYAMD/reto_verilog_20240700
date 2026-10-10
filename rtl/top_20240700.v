
module top_20240700 (
    input wire a, b, c, d,
    input wire [3:0] A, B,
    input wire clk, rst, en,

    output wire u, v,
    output wire [3:0] Y,
    output wire flag_comb,
    output wire [3:0] Q,
    output wire flag_q
);

    // Modulo 1: Logica de control
    control_logic U1 (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .u(u),
        .v(v)
    );

    // Modulo 2: ALU
    datapath U2 (
        .A(A),
        .B(B),
        .u(u),
        .v(v),
        .Y(Y),
        .flag_comb(flag_comb)
    );

    // Modulo 3: Registro de salida
    result_register U3 (
        .clk(clk),
        .rst(rst),
        .en(en),
        .Y(Y),
        .flag_comb(flag_comb),
        .Q(Q),
        .flag_q(flag_q)
    );

endmodule
