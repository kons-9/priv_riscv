`include "riscv64_params.svh"
`include "fetch_types.svh"
`include "decode_types.svh"

module riscv64 (
    input wire clk,
    input wire rst_n
);

    fetch_types::input_t  fetch_input;
    fetch_types::output_t fetch_output;
    assign fetch_input.pc   = 64'h0;

    fetch fetch_inst (
        .fetch_input,
        .fetch_output
    );

    decode_types::input_t  decode_input;
    decode_types::output_t decode_output;
    assign decode_input = fetch_output.decoder;

    decode decode_inst (
        .decode_input,
        .decode_output
    );

    execute_types::input_t  execute_input;
    execute_types::output_t execute_output;
    assign execute_input.clk = clk;

    execute execute_inst (
        .execute_input,
        .execute_output
    );

endmodule
