module ALU (
  input [3:0] opcode,
  input [7:0] operandA,
  input [7:0] operandB,
  output reg [7:0] result
);
  always @(*) begin
    case(opcode)
      4'b0000: result = operandA + operandB;
      4'b0001: result = operandA - operandB;
      4'b0010: result = operandA & operandB;
      4'b0011: result = operandA | operandB;
      default: result = 0;
    endcase
  end
endmodule