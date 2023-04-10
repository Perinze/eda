module vendor # (
  parameter DW = 8
) (
  output ticket_pulse,
  output coin_one_out_pulse,

  input [DW-1:0] input_src,
  input [DW-1:0] input_dest,
  input [DW-1:0] input_count,
  input coin_ten_in_pulse,
  input done,
  input clk,
  input rst_n
);

  wire [DW-1:0] checked_input_ticket_count;
  wire [DW-1:0] coin_ten_cnt;
  wire [DW-1:0] total_insert;
  wire [DW-1:0] total_price;
  wire [DW-1:0] output_ticket_count;
  wire [DW-1:0] change_price;
  wire [DW-1:0] change_one_cnt;
  wire done_oneshot;

  oneshot done_shooter (done_oneshot, done, clk);

  dest_selector #(DW) dest_device (total_price,
                                    checked_input_ticket_count,
                                    input_src,
                                    input_dest,
                                    input_count);

  insert_counter #(DW) coin_ten_counter (coin_ten_cnt, coin_ten_in_pulse, rst_n & ~delayed_done_oneshot);

  dffr #(DW) done_lagger (
    .dnxt(done_oneshot),
    .qout(delayed_done_oneshot),
    .clk(clk),
    .rst_n(rst_n)
  );

  assign total_insert = coin_ten_cnt * 10;

  diffdev #(DW) diff_device (output_ticket_count,
                            change_price,
                            total_insert,
                            total_price,
                            checked_input_ticket_count);

  assign change_one_cnt = change_price;

  count_pulse #(DW) change_one_pulser (coin_one_out_pulse,
                                        change_one_cnt,
                                        done_oneshot,
                                        clk,
                                        rst_n);

  count_pulse #(DW) ticket_pulser (ticket_pulse,
                                    output_ticket_count,
                                    done_oneshot,
                                    clk,
                                    rst_n);

endmodule