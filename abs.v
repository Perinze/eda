module abs # (
  parameter DW = 8
) (
  output [DW-1:0] out,
  input [DW-1:0] in
);

  wire neg;
  wire [DW-1:0] abs;

  assign neg = in[DW-1] == 1'b1;
  assign abs =
          ({DW{~neg}} &  in)
        | ({DW{ neg}} & -in);
  assign out = abs;

endmodule