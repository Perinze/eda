`timescale 1s/1ms
module tb;

wire ticket;
wire one_output;
wire ten_output;

reg [7:0] dest;
reg [7:0] count;
reg one_insert;
reg ten_insert;
reg done;

reg clk;
reg rst_n;

vendor #(8, 16) v0 (ticket,
                    one_output,
                    dest,
                    count,
                    one_insert,
                    ten_insert,
                    done,
                    clk,
                    rst_n);

initial begin
    $dumpfile("vendor.vcd");
    $dumpvars(0, tb);
end

always #(0.5)
    clk = ~clk;

initial begin
    // startup

    // reset input
    dest <= 16;
    count <= 0;
    one_insert <= 0;
    ten_insert <= 0;
    done <= 0;

    // reset clk and reset
    clk <= 1'b0;
    rst_n <= 1'b0;

    // turn of reset
    #(2)
    rst_n <= 1'b1;

    // work

    #(10)
    dest <= 15; // price 2/ticket
    count <= 3; // total 6
    #(1) one_insert <= 1;
    #(1) one_insert <= 0;
    #(1) one_insert <= 1;
    #(1) one_insert <= 0;
    #(1) ten_insert <= 1;
    #(1) ten_insert <= 0; // insert 12
    #(1) done <= 1;
    #(2) done <= 0;

    #(20) $finish;
end

endmodule