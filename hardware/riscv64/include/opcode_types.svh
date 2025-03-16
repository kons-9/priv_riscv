package opcode_types;
    typedef enum logic [3:0] {
        RType,
        IType,
        SType,
        BType,
        UType,
        JType,
        CustomType,
        UnexpectedType
    } instr_type_t;

    typedef enum logic [6:0] {
        // RV32I Base Instruction Set
        LUI      = 7'b0110111,
        AUIPC    = 7'b0010111,
        JAL      = 7'b1101111,
        JALR     = 7'b1100111,
        // BEQ, BNE, BLT, BGE, BLTU, BGEU
        BRANCH   = 7'b1100011,
        // LB, LH, LW, LBU, LHU
        LOAD     = 7'b0000011,
        // SB, SH, SW
        STORE    = 7'b0100011,
        // ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI
        OP_IMM   = 7'b0010011,
        // ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND
        OP       = 7'b0110011,
        // FENCE, FENCE.TSO, PAUSE
        MISC_MEM = 7'b0001111,
        // ECALL, EBREAK
        SYSTEM   = 7'b1110011,

`ifdef UNIMPLEMENTED
        // RV64I Base Instruction Set
        // LWU, LD, SD
        // add to LOAD
        // SD
        // add to STORE
        // SLLI, SRLI, SRAI
        // add to OP_IMM
        // ADDIW, SLLIW, SRLIW, SRAIW
        OP_IMM_32 = 7'b0011011,
        // ADDW, SUBW, SLLW, SRLW, SRAW
        OP_32     = 7'b0111011,

        // RV64 Zifencei Standard Extension
        // FENCE.I
        FENCE_I  = 7'b0001111,

        // RV64 Zicsr Standard Extension
        // CSRRW, CSRRS, CSRRC, CSRRWI, CSRRSI, CSRRCI
        // add to SYSTEM

        // RV32M Standard Extension
        // MUL, MULH, MULHSU, MULHU, DIV, DIVU, REM, REMU
        MUL_DIV  = 7'b0110011,
        // RV64M Standard Extension
        // MULW, DIVW, DIVUW, REMW, REMUW
        MUL_DIV_32 = 7'b0111011,
        // RV32A Standard Extension
        // LR.W, SC.W, AMOSWAP.W, AMOADD.W, AMOXOR.W, AMOAND.W, AMOOR.W,
        // AMOMIN.W, AMOMAX.W, AMOMINU.W, AMOMAXU.W
        ATOMIC   = 7'b0101111,
        // RV64A Standard Extension
        // LR.D, SC.D, AMOSWAP.D, AMOADD.D, AMOXOR.D, AMOAND.D, AMOOR.D,
        // AMOMIN.D, AMOMAX.D, AMOMINU.D, AMOMAXU.D
        // add to ATOMIC
`endif
        UNEXPECTED  = 7'b0000000
    } opcode_t;
endpackage
