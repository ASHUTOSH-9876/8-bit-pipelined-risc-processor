module tb;

  reg clk = 0;
  reg reset = 1;

  // Instantiate the CPU
  RISC_CPU uut (
    .clk(clk),
    .reset(reset)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    $dumpfile("cpu.vcd");
    $dumpvars(0, tb);

    #10 reset = 0;
    #200 $finish;
  end

endmodule
