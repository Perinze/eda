`timescale 1s/1ms
module cnt_tb;

wire [7:0] cnt;
reg clk;
reg rst_n;

reg letsshot;
wire shot;

reg [7:0] a;
reg [7:0] b;
wire [7:0] c;
wire [7:0] d;

insert_counter #(8) c0 (cnt, clk, rst_n);

oneshot o0 (shot, letsshot, clk);

abs #(8) a0 (d, c);

initial begin
    $dumpfile("cnt.vcd");
    $dumpvars(0, cnt_tb);
end

always #(0.5)
    clk = ~clk;

assign c = a - b;

initial begin
    letsshot <= 1'b0;
    clk <= 1'b0;
    rst_n <= 1'b1;
    a <= 4;
    b <= 9;
    #(0.5) rst_n <= 1'b0;
    #(0.5) rst_n <= 1'b1;
    letsshot <= 1'b1;
    #(2) letsshot <= 1'b0;
    #(2) letsshot <= 1'b1;
    #(2) letsshot <= 1'b0;
    //#(32) rst_n <= 1'b0;
    #(1) $finish;
end

endmodule