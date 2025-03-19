`ifndef EXECUTE_TYPES_SVH
`define EXECUTE_TYPES_SVH
`include "types.svh"
`include "decode_types.svh"

package execute_types;
    typedef decode_types::output_t input_t;

    typedef struct packed {logic clk;} output_t;
endpackage

`endif
