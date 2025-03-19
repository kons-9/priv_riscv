`include "fetch_types.svh"

`include "test_utils.svh"

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
        fetch_inst.instr_ram[0]  = 32'hdeadbeef;
        fetch_inst.instr_ram[1]  = 32'h00000000;
        fetch_inst.instr_ram[2]  = 32'h00000001;
        fetch_inst.instr_ram[3]  = 32'h00000002;
        fetch_inst.instr_ram[4]  = 32'h00000003;
        fetch_inst.instr_ram[5]  = 32'h00000004;
        fetch_inst.instr_ram[6]  = 32'h00000005;
        fetch_inst.instr_ram[7]  = 32'h00000006;
        fetch_inst.instr_ram[8]  = 32'h00000007;
        fetch_inst.instr_ram[9]  = 32'h00000008;
        fetch_inst.instr_ram[10] = 32'h00000009;
        fetch_inst.instr_ram[11] = 32'h0000000a;
        fetch_inst.instr_ram[12] = 32'h0000000b;
    endtask


    initial begin
        `TEST_START("tb_fetch.log");
        initialize();
        #1;

        fetch_input.pc = 32'h0; // 0
        expected_output.decoder.instr = 32'hdeadbeef;
        #1;
        `TEST_EXPECTED(expected_output.decoder, fetch_output.decoder, "fetch_output");
        #1;

        fetch_input.pc = 32'h8; // 1000
        expected_output.decoder.instr = 32'h00000001;
        #1;
        `TEST_EXPECTED(expected_output.decoder.instr, fetch_output.decoder.instr, "fetch_output");
        #1;
        fetch_input.pc = 32'h18; // 11000
        expected_output.decoder.instr = 32'h00000005;
        #1
        `TEST_EXPECTED(expected_output.decoder.instr, fetch_output.decoder.instr, "fetch_output");
        #1;

        `TEST_RESULT();
    end
endmodule
