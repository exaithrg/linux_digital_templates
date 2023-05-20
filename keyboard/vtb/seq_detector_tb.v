//***************************************************************
// Description: 
// File Name: testbench.v
// Author: Haoran Geng
// Email: 
// Created Time: Sun 05 Mar 2023 02:08:52 PM CST
// Revision history:
//***************************************************************

`timescale 1ns/1ps

module seq_detector_tb();

    reg clk_i;
    reg rst_n;
    reg a_i;
    wire flag_o;

    reg [15:0] a_bin;

    always @(posedge clk_i, negedge rst_n) begin
        if(!rst_n) begin
            a_bin = 16'b0000_0011_1111_1001;
        end else begin
            a_i <= a_bin[0];
            a_bin <= a_bin >> 1'b1;
        end
    end

    initial begin
        clk_i = 0;
        rst_n = 1;
        # 10;
        rst_n = 1'b0;
        # 20;
        rst_n = 1'b1;
        # 200;
        $stop;
    end

    always #5 clk_i = ~clk_i;

    initial begin
        $dumpfile("./ivbuild/dump.vcd");
        $dumpvars(0,testbench);
    end

    seq_detector u_fsm(
        .clk_i(clk_i),
        .rst_n(rst_n),
        .a_i(a_i),
        .flag_o(flag_o)
    );

endmodule

