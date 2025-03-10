`ifndef FETCH_TYPES_SVH
`define FETCH_TYPES_SVH

package fetch_types;
    typedef struct {
        logic clk;
        logic rst_n;
    } input_t;
    typedef struct {
        logic [63:0] instr;
    } output_t;
endpackage

`endif // FETCH_TYPES_SVH
