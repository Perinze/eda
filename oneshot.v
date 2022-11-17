module oneshot (
  output out,
  input in,
  input clk
);

  wire curr;
  wire prev;

  assign out = (curr == 1'b1) & (prev == 1'b0);

  assign curr = in;
  sirv_gnrl_ltch #(1) oneshot_dffrs (clk, curr, prev);

endmodule