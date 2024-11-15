`include "../Componentes/decodificador_alu.v"
`include "../Componentes/decodificador_principal.v"

module UC(
    input [31:0] instr_UC,
    input zero_UC,
    output regWrite_UC, memWrite_UC, aluSrc_UC, pcSrc_UC,
    output [1:0] resSrc_UC, inmSrc_UC,
    output [2:0] aluControl_UC, type_UC
);

    // Instancia decodificador principal
    wire memWrite_UC_aux; 
    wire aluSrc_UC_aux; 
    wire regWrite_UC_aux; 
    wire resSrc_UC_aux; 
    wire pcSrc_UC_aux;
    wire [1:0] inmSrc_UC_aux; 
    wire [1:0] aluOp_UC_aux; 
    wire [2:0] type_UC_aux; 
    wire [6:0] cod_op = instr_UC[6:0];
    mainDeco decodificadorInstruccion(
        // Input
        .op(cod_op),
        .zero(zero_UC),
        // Output
        .memWrite(memWrite_UC_aux), 
        .aluSrc(aluSrc_UC_aux),
        .regWrite(regWrite_UC_aux),  
        .resSrc(resSrc_UC_aux),
        .inmSrc(inmSrc_UC_aux), 
        .aluOp(aluOp_UC_aux),
        .type_MD(type_UC_aux),
        .pcSrc(pcSrc_UC_aux)
    );

    assign regWrite_UC = regWrite_UC_aux;
    assign memWrite_UC = memWrite_UC_aux;
    assign aluSrc_UC = aluSrc_UC_aux;
    assign resSrc_UC = resSrc_UC_aux;
    assign inmSrc_UC = inmSrc_UC_aux;
    assign type_UC = type_UC_aux;
    assign pcSrc_UC = pcSrc_UC_aux;

    // Instancia del decodificador de ALU
    aluDeco decodificadorAlu(
        // Input
        .op(instr_UC[5]), // Chequear si 4 o 5
        .f7(instr_UC[29]),
        .f3(instr_UC[14:12]),
        .aluOp(aluOp_UC_aux),
        // Output
        .aluControl(aluControl_UC)
    );

endmodule