`include "execute_types.svh"

module execute (
    input  execute_types::input_t  execute_input,
    output execute_types::output_t execute_output
);

    assign execute_output.clk = execute_input.clk;

endmodule
