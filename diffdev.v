module diffdev # (
  parameter DW = 8
) (
  output [DW-1:0] output_count,
  output [DW-1:0] change_price,
  input [DW-1:0] total_insert,
  input [DW-1:0] total_price,
  input [DW-1:0] input_count
);

  wire [DW-1:0] diff;
  wire enough;

  assign diff = total_insert - total_price;
  assign enough = diff[DW-1] == 1'b0;
  assign change_price =
          ({DW{ enough}} & diff)
        | ({DW{~enough}} & total_insert);
  assign output_count = {DW{enough}} & input_count;

endmodule