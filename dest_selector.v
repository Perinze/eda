module dest_selector # (
  parameter DW = 8
) (
  output [DW-1:0] total,
  output [DW-1:0] ticket,
  input [DW-1:0] src,
  input [DW-1:0] dest,
  input [DW-1:0] count
);

  wire valid;
  wire [DW-1:0] diff;
  wire [DW-1:0] dist;
  wire [DW-1:0] price;
  wire [1:0] dir_src;
  wire [1:0] dir_dest;
  wire [DW-3:0] val_src;
  wire [DW-3:0] val_dest;
  wire switch;
  wire [DW-1:0] checked_count;

  assign valid = dest != src;
  assign dir_src = src >> (DW-2);
  assign dir_dest = dest >> (DW-2);
  assign val_src = src & {(DW-2){1'b1}};
  assign val_dest = dest & {(DW-2){1'b1}};
  assign switch = dir_src != dir_dest;

  assign diff = switch ? (val_dest + val_src) : (val_dest - val_src);

  assign checked_count = (count > 4) ? 4 : count;
  assign price = (dist - 1) / 5 + 2;
  assign total = valid ? price * checked_count : 0;
  assign ticket = valid ? checked_count : 0;
  
  abs #(8) abs_dist (dist, diff);

endmodule