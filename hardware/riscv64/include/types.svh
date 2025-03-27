`ifndef TYPES_SVH
`define TYPES_SVH
`include "riscv64_params.svh"
`include "opcode_types.svh"

package types;
    import opcode_types::*;

    localparam int PcWidth = $clog2(riscv64_params::InstrWidth);
    typedef logic [PcWidth-1:0] pc_t;
    typedef logic [riscv64_params::InstrWidth -1:0] instr_t;

    typedef logic [4:0] registor_t;
    typedef logic [2:0] funct3_t;
    typedef logic [6:0] funct7_t;
    typedef logic [31:0] imm_t;

    typedef logic [5:0] shamt_t;
    typedef logic [3:0] fm_t;
    typedef logic [3:0] pred_t;
    typedef logic [2:0] succ_t;

endpackage
`endif  // TYPES_SVH
