module RISC_CPU (
  input clk,
  input reset
);

  // Program Counter
  reg [3:0] pc;

  // Instruction Memory (simple ROM)
  reg [7:0] instr_mem [0:15];
  initial begin
    instr_mem[0] = 8'b00010001; // Example instructions
    instr_mem[1] = 8'b00100010;
    instr_mem[2] = 8'b00000011;
    instr_mem[3] = 8'b00010100;
    instr_mem[4] = 8'b00000101;
    instr_mem[5] = 8'b00000110;
    instr_mem[6] = 8'b00000111;
    instr_mem[7] = 8'b00001000;
  end

  // Register File
  reg [7:0] reg_file [0:3];
  initial begin
    reg_file[0] = 8'd5;
    reg_file[1] = 8'd10;
    reg_file[2] = 8'd15;
    reg_file[3] = 8'd20;
  end

  // Pipeline registers
  reg [7:0] instr_fetch;
  reg [3:0] opcode_decode;
  reg [1:0] dest_decode, src_immed_decode;
  reg [7:0] operandA_execute, operandB_execute;
  reg [3:0] opcode_execute;

  wire [7:0] alu_out;

  // ALU instance
  ALU alu_unit (
    .opcode(opcode_execute),
    .operandA(operandA_execute),
    .operandB(operandB_execute),
    .result(alu_out)
  );

  // FETCH Stage
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pc <= 4'b0;
      instr_fetch <= 8'b0;
    end else begin
      instr_fetch <= instr_mem[pc];
      pc <= pc + 1;
    end
  end

  // DECODE Stage
  always @(posedge clk) begin
    opcode_decode <= instr_fetch[7:4];
    dest_decode <= instr_fetch[3:2];
    src_immed_decode <= instr_fetch[1:0];
  end

  // EXECUTE Stage
  always @(posedge clk) begin
    opcode_execute <= opcode_decode;
    operandA_execute <= reg_file[dest_decode];
    operandB_execute <= reg_file[src_immed_decode];
  end

endmodule
