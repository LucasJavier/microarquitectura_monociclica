module Adder(
    input [31:0] PC, op, // Operandos (PC y el inmediato)
    output [31:0] res // Resultado del calculo (direccion)
); // calcula direcciones

initial res = 32'b0;

assign res = PC + op;

endmodule