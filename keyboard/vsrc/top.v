//***************************************************************
// Description: 
// File Name: fsm.v
// Author: Haoran Geng
// Email: 
// Created Time: Sun 05 Mar 2023 03:31:00 PM CST
// Revision history:
//***************************************************************

module top(
    input clk_i            ,
    input rst_n            ,
    input ps2_clk          ,
    input ps2_data         ,
    output [7:0] seg [7:0] ,
    output ready           ,
    output overflow
);

    wire nextdata_n          ;
    wire [7:0] kbd_data      ;
    wire [1:0] low_ena       ;
    wire [7:0] low_keycode   ;
    wire [1:0] mid_ena       ;
    wire [7:0] mid_asciicode ;
    wire [7:0] high_keycnt   ;

    key_disp_fsm u_kdf(
        .clk_i         ( clk_i         ),
        .rst_n         ( rst_n         ),
        .key           ( kbd_data      ),
        .key_ready     ( ready         ),
        .key_overflow  ( overflow      ),
        .nextdata_n    ( nextdata_n    ),
        .low_keycode   ( low_keycode   ),
        .low_ena       ( low_ena       ),
        .mid_asciicode ( mid_asciicode ),
        .mid_ena       ( mid_ena       ),
        .high_keycnt   ( high_keycnt   )
    );

    ps2_keyboard u_ps2(
        .clk        ( clk_i      ),
        .clrn       ( rst_n      ),
        .nextdata_n ( nextdata_n ),
        .ps2_clk    ( ps2_clk    ),
        .ps2_data   ( ps2_data   ),
        .data       ( kbd_data   ),
        .ready      ( ready      ),
        .overflow   ( overflow   )
    );

    bcd2seg u_off_1(
        .ena(1'b0   ) ,
        .bcd(4'b0   ) ,
        .dot(1'b0   ) ,
        .seg(seg[7] )
    );
    bcd2seg u_off_0(
        .ena(1'b0   ) ,
        .bcd(4'b0   ) ,
        .dot(1'b0   ) ,
        .seg(seg[6] )
    );

    bcd2seg u_high_1(
        .ena(1'b1             ) ,
        .bcd(high_keycnt[7:4] ) ,
        .dot(1'b0             ) ,
        .seg(seg[5]           )
    );
    bcd2seg u_high_0(
        .ena(1'b1             ) ,
        .bcd(high_keycnt[3:0] ) ,
        .dot(1'b1             ) ,
        .seg(seg[4]           )
    );

    bcd2seg u_mid_1(
        .ena(mid_ena[1]         ) ,
        .bcd(mid_asciicode[7:4] ) ,
        .dot(1'b0               ) ,
        .seg(seg[3]             )
    );
    bcd2seg u_mid_0(
        .ena(mid_ena[0]         ) ,
        .bcd(mid_asciicode[3:0] ) ,
        .dot(1'b1               ) ,
        .seg(seg[2]             )
    );

    bcd2seg u_low_1(
        .ena(low_ena[1]       ) ,
        .bcd(low_keycode[7:4] ) ,
        .dot(1'b0             ) ,
        .seg(seg[1]           )
    );
    bcd2seg u_low_0(
        .ena(low_ena[0]       ) ,
        .bcd(low_keycode[3:0] ) ,
        .dot(1'b1             ) ,
        .seg(seg[0]           )
    );


endmodule

