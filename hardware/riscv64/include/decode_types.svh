`ifndef DECODE_TYPES_SVH
`define DECODE_TYPES_SVH
`include "types.svh"
`include "fetch_types.svh"

package decode_types;
    import types::*;
    import opcode_types::*;
    typedef fetch_types::decoder_output_t input_t;

    typedef struct packed {
        instr_type_t instr_type;
        opcode_t opcode;
        registor_t rd;
        funct3_t funct3;
        registor_t rs1;
        registor_t rs2;
        funct7_t funct7;
        imm_t imm;

        shamt_t shamt;
        fm_t fm;
        pred_t pred;
        succ_t succ;
    } output_t;

    typedef struct packed {
        funct7_t   funct7;
        registor_t rs2;
        registor_t rs1;
        funct3_t   funct3;
        registor_t rd;
        opcode_t   opcode;
    } raw_common_t;

    typedef struct packed {
        funct7_t   funct7;
        registor_t rs2;
        registor_t rs1;
        funct3_t   funct3;
        registor_t rd;
        opcode_t   opcode;
    } raw_r_type_t;

    typedef struct packed {
        logic [11:0] imm11_0;
        registor_t rs1;
        funct3_t funct3;
        registor_t rd;
        opcode_t opcode;
    } raw_i_type_t;

    typedef struct packed {
        logic [6:0] imm11_5;
        registor_t rs2;
        registor_t rs1;
        funct3_t funct3;
        registor_t rd;
        logic [4:0] imm4_0;
        opcode_t opcode;
    } raw_s_type_t;

    typedef struct packed {
        logic imm12;
        logic [6:0] imm10_5;
        registor_t rs2;
        registor_t rs1;
        funct3_t funct3;
        logic [4:0] imm4_1;
        logic imm11;
        opcode_t opcode;
    } raw_b_type_t;

    typedef struct packed {
        logic imm20;
        logic [9:0] imm10_1;
        logic imm11;
        logic [7:0] imm19_12;
        registor_t rd;
        opcode_t opcode;
    } raw_j_type_t;

    typedef struct packed {
        logic [19:0] imm31_12;
        registor_t rd;
        opcode_t opcode;
    } raw_u_type_t;

    typedef union packed {
        raw_common_t common;
        raw_r_type_t r;
        raw_i_type_t i;
        raw_s_type_t s;
        raw_b_type_t b;
        raw_u_type_t u;
        raw_j_type_t j;
        instr_t raw;
    } raw_instr_t;

    function automatic types::imm_t get_imm(input decode_types::raw_instr_t instr,
                                  input types::instr_type_t instr_type);

        unique case (instr_type)
            RType: begin
                return 0;
            end
            IType: begin
                return {{20{instr.i.imm11_0[11]}}, instr.i.imm11_0};
            end
            SType: begin
                return {{20{instr.s.imm11_5[11]}}, instr.s.imm11_5, instr.s.imm4_0};
            end
            BType: begin
                return {
                    {19{instr.b.imm12}},
                    instr.b.imm12,
                    instr.b.imm11,
                    instr.b.imm10_5,
                    instr.b.imm4_1,
                    1'b0
                };
            end
            UType: begin
                return {instr.u.imm31_12, 12'b0};
            end
            JType: begin
                return {
                    {11{instr.j.imm20}},
                    instr.j.imm20,
                    instr.j.imm19_12,
                    instr.j.imm11,
                    instr.j.imm10_1,
                    1'b0
                };
            end
            default: begin
                return 0;
            end
        endcase
    endfunction
    function automatic types::instr_type_t get_instr_type(input types::opcode_t opcode);

        case (opcode)
            // R-Type
            opcode_types::OP: begin
                return decode_types::RType;
            end
            // I-Type
            opcode_types::JALR, opcode_types::LOAD, opcode_types::OP_IMM: begin
                return decode_types::IType;
            end
            // S-Type
            opcode_types::STORE: begin
                return decode_types::SType;
            end
            // B-Type
            opcode_types::BRANCH: begin
                return decode_types::BType;
            end
            // U-Type
            opcode_types::LUI, opcode_types::AUIPC: begin
                return decode_types::UType;
            end
            // J-Type
            opcode_types::JAL: begin
                return decode_types::JType;
            end
            // CustomType
            opcode_types::MISC_MEM, opcode_types::SYSTEM: begin
                return decode_types::CustomType;
            end
            default: begin
                return decode_types::UnexpectedType;
            end
        endcase
    endfunction
endpackage

`endif  // DECODE_TYPES_SVH
