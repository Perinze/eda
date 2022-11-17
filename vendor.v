module vendor # (
  parameter DW = 8,
  parameter MYID = 16
) (
  output ticket_pulse,
  output coin_one_out_pulse,
  output coin_ten_out_pulse,

  input [DW-1:0] input_dest,
  input [DW-1:0] input_count,
  input coin_one_in_pulse,
  input coin_ten_in_pulse,
  input done,
  input clk,
  input rst_n
);

  wire [DW-1:0] checked_input_ticket_count;
  wire [DW-1:0] coin_one_cnt;
  wire [DW-1:0] coin_ten_cnt;
  wire [DW-1:0] total_insert;
  wire [DW-1:0] total_price;
  wire [DW-1:0] output_ticket_count;
  wire [DW-1:0] change_price;
  wire [DW-1:0] change_one_cnt;
  wire [DW-1:0] change_ten_cnt;
  wire done_oneshot;

  oneshot done_shooter (done_oneshot, done, clk);

  dest_selector #(DW, MYID) dest_device (total_price,
                                          checked_input_ticket_count,
                                          input_dest,
                                          input_count);

  insert_counter #(DW) coin_one_counter (coin_one_cnt, coin_one_in_pulse, rst_n);
  insert_counter #(DW) coin_ten_counter (coin_ten_cnt, coin_ten_in_pulse, rst_n);

  assign total_insert = coin_one_cnt + coin_ten_cnt * 10;

  diffdev #(DW) diff_device (output_ticket_count,
                            change_price,
                            total_insert,
                            total_price,
                            checked_input_ticket_count);

  assign change_one_cnt = change_price % 10;
  assign change_ten_cnt = change_price / 10;

  count_pulse #(DW) change_one_pulser (coin_one_out_pulse,
                                        change_one_cnt,
                                        done_oneshot,
                                        clk,
                                        rst_n);

  count_pulse #(DW) change_ten_pulser (coin_ten_out_pulse,
                                        change_ten_cnt,
                                        done_oneshot,
                                        clk,
                                        rst_n);

  count_pulse #(DW) ticket_pulser (ticket_pulse,
                                    output_ticket_count,
                                    done_oneshot,
                                    clk,
                                    rst_n);

endmodule