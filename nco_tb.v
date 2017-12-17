`default_nettype none
module test;

  reg load;
  wire [6:0] out;
  reg ce = 1;
  reg [7:0] phase = 1;
  initial begin
     # 2 load = 1;
     # 2 load = 0;

     $dumpfile("test.vcd");
     $dumpvars(0,test);
     # 10000

     $finish;
  end

  /* Make a regular pulsing clock. */
  reg clk = 0;
  always #1 clk = !clk;

    nco #(.W(10)) nco_inst(.i_clk(clk), .i_ce(ce), .o_val(out), .i_dphase(phase), .i_ld(load));

endmodule // test
