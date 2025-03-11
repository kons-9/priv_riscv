`ifndef DECODE_TYPES_SVH
`define DECODE_TYPES_SVH
`include "riscv64_params.svh"

package decode_types;
    typedef struct packed {logic [riscv64_params::INSTR_WIDTH-1:0] instr;} input_t;
    typedef struct packed {logic [riscv64_params::INSTR_WIDTH-1:0] instr;} output_t;
endpackage

`endif  // DECODE_TYPES_SVH
