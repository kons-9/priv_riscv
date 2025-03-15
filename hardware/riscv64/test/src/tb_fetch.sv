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

    task automatic initialize();
        #1;
        fetch_inst.instr_ram[0] = 64'hdeadbeefdeadbeef;
        fetch_inst.instr_ram[1] = 64'hdeadbeef00000000;
        fetch_inst.instr_ram[2] = 64'hdeadbeef00000001;
        fetch_inst.instr_ram[3] = 64'hdeadbeef00000002;
        fetch_inst.instr_ram[4] = 64'hdeadbeef00000003;
        fetch_inst.instr_ram[5] = 64'hdeadbeef00000004;
        fetch_inst.instr_ram[6] = 64'hdeadbeef00000005;
        fetch_inst.instr_ram[7] = 64'hdeadbeef00000006;
        fetch_inst.instr_ram[8] = 64'hdeadbeef00000007;
        fetch_inst.instr_ram[9] = 64'hdeadbeef00000008;
        fetch_inst.instr_ram[10] = 64'hdeadbeef00000009;
        fetch_inst.instr_ram[11] = 64'hdeadbeef0000000a;
        fetch_inst.instr_ram[12] = 64'hdeadbeef0000000b;
    endtask


    initial begin
        `TEST_START("tb_fetch.log");
        initialize();
        #1;

        fetch_input.pc = 64'h0; // 0
        expected_output.instr = 64'hdeadbeefdeadbeef;
        #1;
        `TEST_EXPECTED(expected_output.instr, fetch_output.instr, "fetch_output");
        #1;

        fetch_input.pc = 64'h8; // 1000
        expected_output.instr = 64'hdeadbeef00000000;
        #1;
        `TEST_EXPECTED(expected_output.instr, fetch_output.instr, "fetch_output");
        #1;
        fetch_input.pc = 64'h18; // 11000
        expected_output.instr = 64'hdeadbeef00000002;
        #1
        `TEST_EXPECTED(expected_output.instr, fetch_output.instr, "fetch_output");
        #1;

        `TEST_RESULT();
    end
endmodule
