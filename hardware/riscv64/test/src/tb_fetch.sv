`include "fetch_types.svh"

`include "tb_utils.svh"

module tb_fetch;
    import fetch_types::*;

    input_t  fetch_input;
    output_t fetch_output;

    fetch fetch_inst (
        .fetch_input (fetch_input),
        .fetch_output(fetch_output)
    );

    output_t expected_output;

    initial begin
        `TEST_START("tb_fetch.log");

        fetch_input.clk   = 0;
        fetch_input.rst_n = 0;
        #1;
        fetch_input.clk = 1;
        #1;
        fetch_input.rst_n = 1;
        #1;
        fetch_input.clk = 0;
        #1;
        fetch_input.clk = 1;
        #1;

        expected_output.instr = 64'hdeadbeefdeadbeef;
        `TEST_EXPECTED(fetch_output, expected_output, "fetch_output");

        `TEST_RESULT();
    end
    assign fetch_output.instr = 64'hdeadbeefdeadbeef;
endmodule
