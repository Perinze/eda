module dest_selector # (
  parameter DW = 8,
  parameter MYID = 16
) (
  output [DW-1:0] total,
  output [DW-1:0] ticket,
  input [DW-1:0] dest,
  input [DW-1:0] count
);

  wire valid;
  wire [DW-1:0] diff;
  wire [DW-1:0] dist;
  wire [DW-1:0] price;

  assign valid = dest != MYID;
  assign diff = dest - MYID;
  assign price = (dist - 1) / 5 + 2;
  assign total = valid ? price * count : 0;
  assign ticket = valid ? count : 0;
  
  abs #(8) abs_dist (dist, diff);

endmodule