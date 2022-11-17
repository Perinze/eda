`timescale 1s/1ms
module calc_tb;

wire [7:0] cnt;
reg clk;
reg rst_n;

reg [7:0] coin;
reg [7:0] price;
reg [7:0] count;
wire [7:0] change;
wire [7:0] ticket;

diffdev #(8) d0 (ticket, change, coin, price, count);

initial begin
    $dumpfile("calc.vcd");
    $dumpvars(0, calc_tb);
end

always #(0.5)
    clk = ~clk;

initial begin
    clk <= 1'b0;
    rst_n <= 1'b1;

    coin <= 4;
    price <= 3;
    count <= 114;

    #(1)
    coin <= 20;
    price <= 12;
    count <= 514;

    #(1)
    coin <= 6;
    price <= 12;
    count <= 19;

    #(1)
    coin <= 0;
    price <= 12;
    count <= 810;

    #(1) $finish;
end

endmodule