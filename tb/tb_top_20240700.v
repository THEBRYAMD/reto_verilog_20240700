
`timescale 1ns/1ps

module tb_top_20240700;

    reg [3:0] control, A, B;
    reg clk, rst, en;

    wire u, v;
    wire [3:0] Y, Q;
    wire flag_comb, flag_q;

    reg esperado_u, esperado_v;
    reg [3:0] esperado_Y;
    reg esperado_flag;

    integer i, j, k;
    integer pruebas, errores;
    integer suma_temp;

    // Sistema completo
    top_20240700 dut (
        .a(control[3]),
        .b(control[2]),
        .c(control[1]),
        .d(control[0]),
        .A(A),
        .B(B),
        .clk(clk),
        .rst(rst),
        .en(en),
        .u(u),
        .v(v),
        .Y(Y),
        .flag_comb(flag_comb),
        .Q(Q),
        .flag_q(flag_q)
    );

    initial begin
        $dumpfile("resultados/combinacional.vcd");
        $dumpvars(0, tb_top_20240700);

        clk = 0;
        rst = 0;
        en = 0;
        control = 0;
        A = 0;
        B = 0;
        pruebas = 0;
        errores = 0;

        // Recorrer 4096 combinaciones
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 16; k = k + 1) begin

                    control = i;
                    A = j;
                    B = k;
                    #10;

                    // Modelo independiente: minterms
                    esperado_u =
                        (i==1 || i==3 || i==6 ||
                         i==7 || i==9 || i==10 ||
                         i==11 || i==14 || i==15);

                    esperado_v =
                        (i==4 || i==6 || i==8 ||
                         i==9 || i==11 || i==12 ||
                         i==13 || i==14 || i==15);

                    // Resultados esperados
                    case ({esperado_v, esperado_u})
                        2'b00: begin
                            esperado_Y = j - k;
                            esperado_flag = (j < k);
                        end

                        2'b01: begin
                            esperado_Y = j ^ k;
                            esperado_flag = ^esperado_Y;
                        end

                        2'b10: begin
                            esperado_Y = (j >= k) ? j : k;
                            esperado_flag = (j == k);
                        end

                        2'b11: begin
                            suma_temp = j + k;
                            esperado_Y = suma_temp;
                            esperado_flag = (suma_temp > 15);
                        end
                    endcase

                    pruebas = pruebas + 1;

                    if (u !== esperado_u ||
                        v !== esperado_v ||
                        Y !== esperado_Y ||
                        flag_comb !== esperado_flag) begin

                        if (errores < 10)
                            $display(
                                "ERROR control=%b A=%d B=%d",
                                control, j, k
                            );

                        errores = errores + 1;
                    end
                end
            end
        end

        $display("----------------------------");
        $display("PRUEBAS: %0d", pruebas);
        $display("ERRORES: %0d", errores);

        if (errores == 0)
            $display("EXITO: 4096 PRUEBAS APROBADAS");
        else
            $display("FALLO EN LA VERIFICACION");

        $finish;
    end

endmodule
