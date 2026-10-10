
module datapath (
    input wire [3:0] A, B,
    input wire u, v,
    output wire [3:0] Y,
    output wire flag_comb
);

    wire [1:0] selector;
    wire [4:0] suma_completa;
    wire [3:0] resta, xor_result, mayor;

    assign selector = {v, u};

    // Operaciones matematicas
    assign suma_completa = {1'b0, A} + {1'b0, B};
    assign resta = A - B;
    assign xor_result = A ^ B;
    assign mayor = (A >= B) ? A : B;

    // Seleccionar operacion
    assign Y = (selector == 2'b00) ? resta :
               (selector == 2'b01) ? xor_result :
               (selector == 2'b10) ? mayor :
                                     suma_completa[3:0];

    // Indicador de cada operacion
    assign flag_comb =
        (selector == 2'b00) ? (A < B) :
        (selector == 2'b01) ? (^xor_result) :
        (selector == 2'b10) ? (A == B) :
                              suma_completa[4];

endmodule
