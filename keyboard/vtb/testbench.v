//***************************************************************
// File Name: testbench.v
// Author: Haoran Geng
// Email: 
// Description: 
// Revision history:
//***************************************************************

`timescale 1ns / 1ps
module testbench;

parameter clock_period = 10;

reg clk_i            ;
reg rst_n            ;
wire ps2_clk         ;
wire ps2_data        ;
wire [7:0] seg [7:0] ;
wire ready           ;
wire overflow        ;

initial clk_i = 1'b0;
always #(clock_period/2) clk_i = ~clk_i;

initial begin
    rst_n = 1'b0;  #20;
    rst_n = 1'b1;  #20;

    u_keyboard_model.kbd_sendcode(8'h1C); // press 'A'
    #1000;
    u_keyboard_model.kbd_sendcode(8'hF0); // break code
    #400;
    u_keyboard_model.kbd_sendcode(8'h1C); // release 'A'
    #400;

    u_keyboard_model.kbd_sendcode(8'h1B); // press 'S'
    #200 u_keyboard_model.kbd_sendcode(8'h1B); // keep pressing 'S'
    #200 u_keyboard_model.kbd_sendcode(8'h1B); // keep pressing 'S'
    u_keyboard_model.kbd_sendcode(8'hF0); // break code
    u_keyboard_model.kbd_sendcode(8'h1B); // release 'S'
    #2000;
    $stop;
end

initial begin
    $dumpfile("./ivbuild/dump.vcd");
    $dumpvars(0,testbench);
end

ps2_keyboard_model u_keyboard_model(
    .ps2_clk  ( ps2_clk  ) ,
    .ps2_data ( ps2_data )
);

top u_top(
    .clk_i    ( clk_i    ) ,
    .rst_n    ( rst_n    ) ,
    .ps2_clk  ( ps2_clk  ) ,
    .ps2_data ( ps2_data ) ,
    .seg      ( seg      ) ,
    .ready    ( ready    ) ,
    .overflow ( overflow )
);

endmodule
