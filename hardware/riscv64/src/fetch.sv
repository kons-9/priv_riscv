`include "fetch_types.svh"

module fetch (
    input  fetch_types::input_t  fetch_input,
    output fetch_types::output_t fetch_output
);
    assign fetch_output.instr = 64'hdeadbeefdeadbeef;
endmodule
