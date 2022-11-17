module insert_counter # (
  parameter DW = 8
) (
  output [DW-1:0] qout,
    
  input clk,
  input rst_n
);

  wire [DW-1:0] cur_cnt;
  wire [DW-1:0] nxt_cnt;

  assign nxt_cnt =
          ({DW{ rst_n}} & cur_cnt + 1)
        | ({DW{~rst_n}} & {DW{1'b0}});

  assign qout = cur_cnt;

  dffrs #(DW) cnt_dffrs (nxt_cnt, cur_cnt, clk, rst_n);

endmodule