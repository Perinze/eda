`timescale 1s/1ms
module tb;

wire ticket;
wire one_output;
wire ten_output;

reg [7:0] src;
reg [7:0] dest;
reg [7:0] count;
reg ten_insert;
reg done;

reg clk;
reg rst_n;

vendor #(8, 16) v0 (ticket,
                    one_output,
                    src,
                    dest,
                    count,
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
    src <= 0;
    dest <= 0;
    count <= 0;
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
    src <=  8'b10000111;
    dest <= 8'b10000001; // price 3/ticket
    count <= 3; // total 9
    #(1) ten_insert <= 1;
    #(1) ten_insert <= 0; // insert 10, change 1
    #(1) done <= 1;
    #(2) done <= 0;

    #(10)
    src <=  8'b10000010;
    dest <= 8'b11010001; // price 5/ticket
    count <= 5; // total 20
    #(1) ten_insert <= 1;
    #(1) ten_insert <= 0;
    #(1) ten_insert <= 1;
    #(1) ten_insert <= 0; // insert 20, change 0
    #(1) done <= 1;
    #(2) done <= 0;

    #(10)
    src <=  8'b00000101;
    dest <= 8'b10001011; // price 5/ticket
    count <= 3; // total 15
    #(1) ten_insert <= 1;
    #(1) ten_insert <= 0;
    #(1) ten_insert <= 1;
    #(1) ten_insert <= 0; // insert 20, change 5
    #(1) done <= 1;
    #(2) done <= 0;

    #(10)
    src <=  8'b00000101;
    dest <= 8'b10001011; // price 5/ticket
    count <= 3; // total 15
    #(1) ten_insert <= 1;
    #(1) ten_insert <= 0; // insert 10, no ticket
    #(1) done <= 1;
    #(2) done <= 0;

    #(20) $finish;
end

endmodule