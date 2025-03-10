`include "fetch_types.svh"
`include "decode_types.svh"

module decode (
    input decode_types::input_t decode_input,
    output decode_types::output_t decode_output
);
    assign decode_output.instr = decode_input.instr;
endmodule
