`include "decode_types.svh"
`include "fetch_types.svh"

`include "tb_utils.svh"

module tb_decode;
    decode_types::input_t  decode_input;
    decode_types::output_t decode_output;

    decode decode_inst (
        .decode_input (decode_input),
        .decode_output(decode_output)
    );

    decode_types::output_t expected_output;

    initial begin
        `TEST_START("tb_decode.log");

        #1;

        // _start:
        //  0:   080002b7                lui     t0,0x8000
        //  4:   08000317                auipc   t1,0x8000
        //  8:   ff9ff2ef                jal     t0,0 <_start>
        //  c:   00028367                jalr    t1,t0 # 8000000 <_start+0x8000000>
        // 10:   00629463                bne     t0,t1,18 <_start+0x18>
        // 18:   00628463                beq     t0,t1,20 <_start+0x20>
        // 20:   0062d463                bge     t0,t1,28 <_start+0x28>
        // 28:   0062c463                blt     t0,t1,30 <_start+0x30>
        // 30:   0062f463                bgeu    t0,t1,38 <_start+0x38>
        // 38:   0062e463                bltu    t0,t1,40 <_start+0x40>
        // 40:   00030283                lb      t0,0(t1) # 8000004 <_start+0x8000004>
        // 44:   00031283                lh      t0,0(t1)
        // 48:   00032283                lw      t0,0(t1)
        // 4c:   00034283                lbu     t0,0(t1)
        // 50:   00035283                lhu     t0,0(t1)
        // 54:   00530023                sb      t0,0(t1)
        // 58:   00531023                sh      t0,0(t1)
        // 5c:   00532023                sw      t0,0(t1)
        // 60:   00030293                addi    t0,t1
        // 64:   00032293                slti    t0,t1,0
        // 68:   00033293                sltiu   t0,t1,0
        // 6c:   00034293                xori    t0,t1,0
        // 70:   00036293                ori     t0,t1,0
        // 74:   00037293                andi    t0,t1,0
        // 78:   00031293                slli    t0,t1,0x0
        // 7c:   00035293                srli    t0,t1,0x0
        // 80:   40035293                srai    t0,t1,0x0
        // 84:   005302b3                add     t0,t1,t0
        // 88:   405302b3                sub     t0,t1,t0
        // 8c:   005312b3                sll     t0,t1,t0
        // 90:   005322b3                slt     t0,t1,t0
        // 94:   005332b3                sltu    t0,t1,t0
        // 98:   005342b3                xor     t0,t1,t0
        // 9c:   005352b3                srl     t0,t1,t0
        // a0:   405352b3                sra     t0,t1,t0
        // a4:   005362b3                or      t0,t1,t0
        // a8:   005372b3                and     t0,t1,t0
        // ac:   0ff0000f                fence
        // b0:   8330000f                fence.tso
        // b4:   00000073                ecall
        // b8:   00100073                ebreak
        `ENABLE_FATAL();
        `ENABLE_IMMIDIATE_EXIT();

        decode_input.instr = 32'h0800_02b7; // lui     t0,0x8000
        // 0000_0100_0000_0000_0000_0010_1011_0111
        decode_input.pc    = 32'h0;
        expected_output.opcode = opcode_types::LUI;
        expected_output.rd     = 5;
        expected_output.imm    = 32'h8000000; // 0x8000 << 12
        
        #1;
        // U-Type
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "lui");
        `TEST_EXPECTED(expected_output.rd, decode_output.rd, "lui");
        `TEST_EXPECTED(expected_output.imm, decode_output.imm, "lui");
        #1;

        decode_input.instr = 32'h08000317; // auipc   t1,0x8000
        decode_input.pc    = 32'h4;
        expected_output.opcode = opcode_types::AUIPC;
        expected_output.rd     = 6;
        expected_output.imm    = 32'h8000000; // 0x8000 << 12
        #1;
        // U-Type
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "auipc");
        `TEST_EXPECTED(expected_output.rd, decode_output.rd, "auipc");
        `TEST_EXPECTED(expected_output.imm, decode_output.imm, "auipc");
        #1;

        decode_input.instr = 32'hff9ff2ef; // jal     t0,0 <_start>
        // this operation address is 0x8
        decode_input.pc    = 32'h8;
        expected_output.opcode = opcode_types::JAL;
        expected_output.rd     = 5;
        expected_output.imm    = -8;
        #1;
        // J-Type
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "jal");
        `TEST_EXPECTED(expected_output.rd, decode_output.rd, "jal");
        `TEST_EXPECTED(expected_output.imm, decode_output.imm, "jal");
        #1;

        decode_input.instr = 32'h00028367; // jalr    t1,t0 # 8000000 <_start+0x8000000>
        decode_input.pc    = 32'h0xc;
        expected_output.opcode = opcode_types::JALR;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "jalr");
        #1;

        decode_input.instr = 32'h00629463; // bne     t0,t1,18 <_start+0x18>
        decode_input.pc    = 32'h0x10;
        expected_output.opcode = opcode_types::BRANCH;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "bne");
        #1;

        decode_input.instr = 32'h00628463; // beq     t0,t1,20 <_start+0x20>
        decode_input.pc    = 32'h0x18;
        expected_output.opcode = opcode_types::BRANCH;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "beq");
        #1;

        decode_input.instr = 32'h0062d463; // bge     t0,t1,28 <_start+0x28>
        decode_input.pc    = 32'h0x20;
        expected_output.opcode = opcode_types::BRANCH;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "bge");
        #1;

        decode_input.instr = 32'h0062c463; // blt     t0,t1,30 <_start+0x30>
        decode_input.pc    = 32'h0x28;
        expected_output.opcode = opcode_types::BRANCH;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "blt");
        #1;

        decode_input.instr = 32'h0062f463; // bgeu    t0,t1,38 <_start+0x38>
        decode_input.pc    = 32'h0x30;
        expected_output.opcode = opcode_types::BRANCH;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "bgeu");
        #1;

        decode_input.instr = 32'h0062e463; // bltu    t0,t1,40 <_start+0x40>
        decode_input.pc    = 32'h0x38;
        expected_output.opcode = opcode_types::BRANCH;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "bltu");
        #1;

        decode_input.instr = 32'h00030283; // lb      t0,0(t1) # 8000004 <_start+0x8000004>
        decode_input.pc    = 32'h0x40;
        expected_output.opcode = opcode_types::LOAD;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "lb");
        #1;

        decode_input.instr = 32'h00031283; // lh      t0,0(t1)
        decode_input.pc    = 32'h0x44;
        expected_output.opcode = opcode_types::LOAD;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "lh");
        #1;

        decode_input.instr = 32'h00032283; // lw      t0,0(t1)
        decode_input.pc    = 32'h0x48;
        expected_output.opcode = opcode_types::LOAD;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "lw");
        #1;

        decode_input.instr = 32'h00034283; // lbu     t0,0(t1)
        decode_input.pc    = 32'h0x4c;
        expected_output.opcode = opcode_types::LOAD;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "lbu");
        #1;

        decode_input.instr = 32'h00035283; // lhu     t0,0(t1)
        decode_input.pc    = 32'h0x50;
        expected_output.opcode = opcode_types::LOAD;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "lhu");
        #1;

        decode_input.instr = 32'h00530023; // sb      t0,0(t1)
        decode_input.pc    = 32'h0x54;
        expected_output.opcode = opcode_types::STORE;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "sb");
        #1;

        decode_input.instr = 32'h00531023; // sh      t0,0(t1)
        decode_input.pc    = 32'h0x58;
        expected_output.opcode = opcode_types::STORE;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "sh");
        #1;

        decode_input.instr = 32'h00532023; // sw      t0,0(t1)
        decode_input.pc    = 32'h0x5c;
        expected_output.opcode = opcode_types::STORE;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "sw");
        #1;

        decode_input.instr = 32'h00030293; // addi      t0,t1
        decode_input.pc    = 32'h0x60;
        expected_output.opcode = opcode_types::OP_IMM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "mv");
        #1;

        decode_input.instr = 32'h00032293; // slti    t0,t1,0
        decode_input.pc    = 32'h0x64;
        expected_output.opcode = opcode_types::OP_IMM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "slti");
        #1;

        decode_input.instr = 32'h00033293; // sltiu   t0,t1,0
        decode_input.pc    = 32'h0x68;
        expected_output.opcode = opcode_types::OP_IMM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "sltiu");
        #1;

        decode_input.instr = 32'h00034293; // xori    t0,t1,0
        decode_input.pc    = 32'h0x6c;
        expected_output.opcode = opcode_types::OP_IMM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "xori");
        #1;

        decode_input.instr = 32'h00036293; // ori     t0,t1,0
        decode_input.pc    = 32'h0x70;
        expected_output.opcode = opcode_types::OP_IMM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "ori");
        #1;

        decode_input.instr = 32'h00037293; // andi    t0,t1,0
        decode_input.pc    = 32'h0x74;
        expected_output.opcode = opcode_types::OP_IMM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "andi");
        #1;

        decode_input.instr = 32'h00031293; // slli    t0,t1,0x0
        decode_input.pc    = 32'h0x78;
        expected_output.opcode = opcode_types::OP_IMM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "slli");
        #1;

        decode_input.instr = 32'h00035293; // srli    t0,t1,0x0
        decode_input.pc    = 32'h0x7c;
        expected_output.opcode = opcode_types::OP_IMM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "srli");
        #1;

        decode_input.instr = 32'h40035293; // srai    t0,t1,0x0
        decode_input.pc    = 32'h0x80;
        expected_output.opcode = opcode_types::OP_IMM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "srai");
        #1;

        decode_input.instr = 32'h005302b3; // add     t0,t1,t0
        decode_input.pc    = 32'h0x84;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "add");
        #1;

        decode_input.instr = 32'h405302b3; // sub     t0,t1,t0
        decode_input.pc    = 32'h0x88;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "sub");
        #1;

        decode_input.instr = 32'h005312b3; // sll     t0,t1,t0
        decode_input.pc    = 32'h0x8c;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "sll");
        #1;

        decode_input.instr = 32'h005322b3; // slt     t0,t1,t0
        decode_input.pc    = 32'h0x90;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "slt");
        #1;

        decode_input.instr = 32'h005332b3; // sltu    t0,t1,t0
        decode_input.pc    = 32'h0x94;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "sltu");
        #1;

        decode_input.instr = 32'h005342b3; // xor     t0,t1,t0
        decode_input.pc    = 32'h0x98;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "xor");
        #1;

        decode_input.instr = 32'h005352b3; // srl     t0,t1,t0
        decode_input.pc    = 32'h0x9c;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "srl");
        #1;

        decode_input.instr = 32'h405352b3; // sra     t0,t1,t0
        decode_input.pc    = 32'h0xa0;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "sra");
        #1;

        decode_input.instr = 32'h005362b3; // or      t0,t1,t0
        decode_input.pc    = 32'h0xa4;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "or");
        #1;

        decode_input.instr = 32'h005372b3; // and     t0,t1,t0
        decode_input.pc    = 32'h0xa8;
        expected_output.opcode = opcode_types::OP;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "and");
        #1;

        decode_input.instr = 32'h0ff0000f; // fence
        decode_input.pc    = 32'h0xac;
        expected_output.opcode = opcode_types::MISC_MEM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "fence");
        #1;

        decode_input.instr = 32'h8330000f; // fence.tso
        decode_input.pc    = 32'h0xb0;
        expected_output.opcode = opcode_types::MISC_MEM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "fence.tso");
        #1;

        decode_input.instr = 32'h00000073; // ecall
        decode_input.pc    = 32'h0xb4;
        expected_output.opcode = opcode_types::SYSTEM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "ecall");
        #1;

        decode_input.instr = 32'h00100073; // ebreak
        decode_input.pc    = 32'h0xb8;
        expected_output.opcode = opcode_types::SYSTEM;
        #1;
        `TEST_EXPECTED(expected_output.opcode, decode_output.opcode, "ebreak");
        #1;

        `TEST_RESULT();
    end
endmodule
