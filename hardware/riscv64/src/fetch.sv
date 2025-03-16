`include "fetch_types.svh"

module fetch (
    input  fetch_types::input_t  fetch_input,
    output fetch_types::output_t fetch_output
);
    reg [types::PcWidth-1:0] pc;

    // using harvard architecture
    reg [riscv64_params::InstrWidth - 1:0] instr_ram[0:1023];

    initial begin
        $readmemh(riscv64_params::InstrRomFile, instr_ram);
    end

    // 64bit / 8bit(=1byte) = 8
    // 8 = 2^3
    localparam int PcShift = $clog2(riscv64_params::InstrWidth / 8);
    assign fetch_output.decoder.instr = instr_ram[fetch_input.pc>>PcShift];
    assign fetch_output.decoder.pc    = fetch_input.pc;

endmodule
