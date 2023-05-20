//***************************************************************
// File Name: keyboard_sim.v
// Author: Haoran Geng
// Email: 
// Created Time: 2023年05月19日 星期五 19时28分39秒
// Description: 
// Revision history:
//***************************************************************

`timescale 1ns / 1ps
module keyboard_sim;

/* parameter */
parameter [31:0] clock_period = 10;

/* ps2_keyboard interface signals */
reg clk,clrn;
wire [7:0] data;
wire ready,overflow;
wire kbd_clk, kbd_data;
reg nextdata_n;

ps2_keyboard_model u_keyboard_model(
    .ps2_clk(kbd_clk),
    .ps2_data(kbd_data)
);

ps2_keyboard u_keyboard_receiver(
    .clk(clk),
    .clrn(clrn),
    .ps2_clk(kbd_clk),
    .ps2_data(kbd_data),
    .data(data),
    .ready(ready),
    .nextdata_n(nextdata_n),
    .overflow(overflow)
);

initial begin /* clock driver */
    clk = 0;
    forever
        #(clock_period/2) clk = ~clk;
end

initial begin
    clrn = 1'b0;  #20;
    clrn = 1'b1;  #20;
    nextdata_n = 1'b1;

    u_keyboard_model.kbd_sendcode(8'h1C); // press 'A'
    #1000 nextdata_n =1'b0;
    #4000 nextdata_n =1'b1; //read data
    u_keyboard_model.kbd_sendcode(8'hF0); // break code
    #200 nextdata_n =1'b0;
    #200 nextdata_n =1'b1; //read data
    u_keyboard_model.kbd_sendcode(8'h1C); // release 'A'
    #200 nextdata_n =1'b0;
    #200 nextdata_n =1'b1; //read data

    u_keyboard_model.kbd_sendcode(8'h1B); // press 'S'
    #200 u_keyboard_model.kbd_sendcode(8'h1B); // keep pressing 'S'
    #200 u_keyboard_model.kbd_sendcode(8'h1B); // keep pressing 'S'
    u_keyboard_model.kbd_sendcode(8'hF0); // break code
    u_keyboard_model.kbd_sendcode(8'h1B); // release 'S'
    #200 nextdata_n =1'b0;
    #200 nextdata_n =1'b1; //read data
    #200 nextdata_n =1'b0;
    #200 nextdata_n =1'b1; //read data
    #200 nextdata_n =1'b0;
    #200 nextdata_n =1'b1; //read data
    $stop;
end

initial begin
    $dumpfile("./ivbuild/dump.vcd");
    $dumpvars(0,keyboard_sim);
end

endmodule

