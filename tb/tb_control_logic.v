
`timescale 1ns/1ps

module tb_control_logic;

    reg [3:0] control;
    wire u, v;

    reg esperado_u, esperado_v;
    integer i, errores;

    control_logic dut (
        .a(control[3]),
        .b(control[2]),
        .c(control[1]),
        .d(control[0]),
        .u(u),
        .v(v)
    );

    initial begin
        errores = 0;

        for (i = 0; i < 16; i = i + 1) begin
            control = i;
            #10;

            // Minterms originales del profesor
            esperado_u = (i==1 || i==3 || i==6 ||
                          i==7 || i==9 || i==10 ||
                          i==11 || i==14 || i==15);

            esperado_v = (i==4 || i==6 || i==8 ||
                          i==9 || i==11 || i==12 ||
                          i==13 || i==14 || i==15);

            if (u !== esperado_u || v !== esperado_v) begin
                $display("ERROR: vector %d", i);
                errores = errores + 1;
            end
        end

        if (errores == 0)
            $display("EXITO: 16 combinaciones correctas");
        else
            $display("FALLOS: %d", errores);

        $finish;
    end

endmodule
