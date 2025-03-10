`include "tb_utils.svh"

module tb_top;
    logic expected;

    initial begin
        `TEST_START("tb_top.log");
        #1;
        expected = 1;
        `TEST_EXPECTED(expected, 1, "1 == 1");
        #1;
        $display("expected = %0h", expected);
        begin
            `TEST_SECTION_START("section1");
            expected = 1;
            `TEST_EXPECTED(expected, 1, "1 == 1");
            `TEST_EXPECTED(expected, 0, "1 == 0");
            `TEST_SECTION_END();
        end
        begin
            `TEST_SECTION_START("section2");
            expected = 1;
            `TEST_EXPECTED(expected, 1, "1 == 1");
            `TEST_EXPECTED(expected, 0, "1 == 0");
            `TEST_SECTION_END();
        end
        expected = 0;
        `TEST_EXPECTED(expected, 1, "1 == 1");

        `TEST_RESULT();
    end
endmodule
