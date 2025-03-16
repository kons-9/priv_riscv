`ifndef FETCH_TYPES_SVH
`define FETCH_TYPES_SVH

`include "types.svh"

package fetch_types;
    typedef struct packed {types::pc_t pc;} input_t;

    typedef struct packed {
        types::instr_t instr;
        types::pc_t pc;
    } decoder_output_t;
    typedef struct packed {
        decoder_output_t decoder;
    } output_t;
endpackage

`endif  // FETCH_TYPES_SVH
