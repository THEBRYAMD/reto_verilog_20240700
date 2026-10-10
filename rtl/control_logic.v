
module control_logic (
    input wire a, b, c, d,
    output wire u, v
);
//ecuacuines 
assign u = (~b & d) | (b & c) | (a & c);
assign v = (a & d) | (a & ~c) | (b & ~d);

endmodule
