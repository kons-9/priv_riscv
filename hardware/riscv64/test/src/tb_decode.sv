`include "decode_types.svh"
`include "tb_utils.svh"

module tb_decode;
    import decode_types::*;

    input_t  decode_input;
    output_t decode_output;

    decode decode_inst (
        .decode_input (decode_input),
        .decode_output(decode_output)
    );

    output_t expected_output;

    initial begin
        `TEST_START("tb_decode.log");

        decode_input.instr = 64'hdeadbeefdeadbeef;
        expected_output.instr = 64'hdeadbeefdeadbeef;
        #1;
        `TEST_EXPECTED(decode_output, expected_output, "decode_output");

        `TEST_RESULT();
    end
endmodule
