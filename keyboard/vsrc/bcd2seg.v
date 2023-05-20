//***************************************************************
// Description: 
// File Name: bcd2seg.v
// Author: Haoran Geng
// Email: 
// Created Time: Fri 03 Mar 2023 09:01:57 PM CST
// Revision history:
//***************************************************************

module bcd2seg(
    input        ena,
    input  [3:0] bcd,
    input        dot,
    output [7:0] seg
);

    reg    [6:0] seg_r;

    always @* begin
        case(bcd)
            // Note: 0 1 2 3 4 5 6 DP
            // https://nju-projectn.github.io/dlco-lecture-note/exp/02.html
            4'b0000: seg_r = 7'b1111110; // 0
            4'b0001: seg_r = 7'b0110000; // 1
            4'b0010: seg_r = 7'b1101101; // 2
            4'b0011: seg_r = 7'b1111001; // 3
            4'b0100: seg_r = 7'b0110011; // 4
            4'b0101: seg_r = 7'b1011011; // 5
            4'b0110: seg_r = 7'b1011111; // 6
            4'b0111: seg_r = 7'b1110000; // 7
            4'b1000: seg_r = 7'b1111111; // 8
            4'b1001: seg_r = 7'b1111011; // 9
            4'b1010: seg_r = 7'b1110111; // A
            4'b1011: seg_r = 7'b0011111; // b
            4'b1100: seg_r = 7'b1001110; // C
            4'b1101: seg_r = 7'b0111101; // d
            4'b1110: seg_r = 7'b1001111; // E
            4'b1111: seg_r = 7'b1000111; // F
            // default: seg_r = 7'b0000000; // ALL OFF
        endcase
    end

    assign seg = ena ? ~{seg_r,dot} : 8'b1111_1111;

endmodule

