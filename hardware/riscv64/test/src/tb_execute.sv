`include "execute_types.svh"
`include "tb_utils.svh"

module tb_execute ();
    execute_types::input_t  execute_input;
    execute_types::output_t execute_output;

    execute execute_inst (
        .execute_input,
        .execute_output
    );

    execute_types::output_t expected_output;

    initial begin
        `TEST_START("tb_execute.log");

        execute_input.clk   = 0;
        expected_output.clk = 0;
        #1;
        `TEST_EXPECTED(execute_output, execute_output, "execute_output");

        `TEST_RESULT();
    end
endmodule
