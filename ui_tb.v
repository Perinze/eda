`timescale 1s/1ms
module ui_tb;

reg clk;
reg rst_n;
reg lden;
wire pulse;

reg [7:0] dest;
reg [7:0] count;
wire [7:0] total;
wire [7:0] ticket;

initial begin
    $dumpfile("ui.vcd");
    $dumpvars(0, ui_tb);
end

always #(0.5)
    clk = ~clk;

dest_selector #(8, 16) d0 (total, ticket, dest, count);

initial begin
    dest <= 10;
    count <= 5;
    #(1)
    dest <= 17;
    count <= 2;
    #(1)
    dest <= 16;
    count <= 114;
    #(2) $finish;
end

endmodule