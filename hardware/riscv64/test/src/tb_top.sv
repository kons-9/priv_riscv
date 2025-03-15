`include "tb_utils.svh"

module tb_top;
    logic clk;
    logic rst_n;

    riscv64 riscv64_inst (
        .clk  (clk),
        .rst_n(rst_n)
    );

    initial begin
        clk   = 0;
        rst_n = 0;
        `TEST_START("tb_top.log");

        `TEST_RESULT();
    end
endmodule
