`ifndef FETCH_TYPES_SVH
`define FETCH_TYPES_SVH

`include "riscv64_params.svh"

package fetch_types;
    localparam int PcWidth = $clog2(riscv64_params::InstrWidth);
    typedef struct {logic [PcWidth-1:0] pc;} input_t;
    typedef struct {logic [riscv64_params::InstrWidth -1:0] instr;} output_t;
endpackage

`endif  // FETCH_TYPES_SVH
