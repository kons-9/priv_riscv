`include "fetch_types.svh"
`include "decode_types.svh"

module decode (
    input  decode_types::input_t  decode_input,
    output decode_types::output_t decode_output
);

    decode_types::raw_instr_t raw_instr;
    assign raw_instr.raw = decode_input.instr;

    types::pc_t pc;
    assign pc = decode_input.pc;

    types::instr_type_t instr_type;
    assign instr_type = decode_types::get_instr_type(raw_instr.common.opcode);

    assign decode_output.opcode = raw_instr.common.opcode;
    assign decode_output.rd = raw_instr.common.rd;
    assign decode_output.funct3 = raw_instr.common.funct3;
    assign decode_output.rs1 = raw_instr.common.rs1;
    assign decode_output.rs2 = raw_instr.common.rs2;
    assign decode_output.funct7 = raw_instr.common.funct7;
    assign decode_output.instr_type = instr_type;
    assign decode_output.imm = decode_types::get_imm(decode_input.instr, instr_type);

    assign decode_output.shamt = raw_instr.common.rs2;
    assign decode_output.fm = raw_instr.raw[31:28];
    assign decode_output.pred = raw_instr.raw[27:24];
    assign decode_output.succ = raw_instr.raw[23:21];

endmodule
