/*
 * output the same number of pulse as input as count
 */
module count_pulse # (
  parameter DW = 8
) (
  output qout,
  input [DW-1:0] in,
  input lden,
  input clk,
  input rst_n
);

  wire [DW-1:0] cur_cnt;
  wire [DW-1:0] nxt_cnt;
  wire [DW-1:0] minus_one;
  wire pos;

  assign pos = (cur_cnt > 0);
  assign minus_one =
          ({DW{ pos}} & cur_cnt - 1)
        | ({DW{~pos}} & 0);

  assign nxt_cnt =
          ({DW{~lden}} & minus_one)
        | ({DW{ lden}} & in);

  assign qout = (cur_cnt > 0) & clk;

  dffr #(DW) cnt_dffr (nxt_cnt, cur_cnt, clk, rst_n);

endmodule