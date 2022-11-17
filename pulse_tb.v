`timescale 1s/1ms
module pulse_tb;

reg [7:0] cnt;
reg clk;
reg rst_n;
reg lden;
wire pulse;

initial begin
    $dumpfile("pulse.vcd");
    $dumpvars(0, pulse_tb);
end

always #(0.5)
    clk = ~clk;

count_pulse #(8) c0 (pulse, cnt, lden, clk, rst_n);

initial begin
    cnt <= 9;
    clk <= 1'b0;
    lden <= 1'b0;
    rst_n <= 1'b0;
    #(1) rst_n <= 1'b1;
    #(1) lden <= 1'b1;
    #(1) lden <= 1'b0;
    //#(32) rst_n <= 1'b0;
    #(32) $finish;
end

endmodule