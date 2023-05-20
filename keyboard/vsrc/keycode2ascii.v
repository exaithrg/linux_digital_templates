//***************************************************************
// File Name: keycode2ascii.v
// Author: Haoran Geng
// Email: 
// Created Time: 23.5.20
// Description: 
// Revision history:
//***************************************************************

module keycode2ascii(
    input      [7:0] keycode   ,
    output reg [6:0] asciicode
);

    always @* begin
        case(keycode)
            8'h45: asciicode = 7'h30; // 0, 7'd48
            8'h16: asciicode = 7'h31; // 1, 7'd49
            8'h1E: asciicode = 7'h32; // 2, 7'd50
            8'h26: asciicode = 7'h33; // 3, 7'd51
            8'h25: asciicode = 7'h34; // 4, 7'd52
            8'h2E: asciicode = 7'h35; // 5, 7'd53
            8'h36: asciicode = 7'h36; // 6, 7'd54
            8'h3D: asciicode = 7'h37; // 7, 7'd55
            8'h3E: asciicode = 7'h38; // 8, 7'd56
            8'h46: asciicode = 7'h39; // 9, 7'd57

            8'h1C: asciicode = 7'h61; // a, 7'd97
            8'h32: asciicode = 7'h62; // b, 7'd98
            8'h21: asciicode = 7'h63; // c, 7'd99
            8'h23: asciicode = 7'h64; // d, 7'd100
            8'h24: asciicode = 7'h65; // e, 7'd101
            8'h2B: asciicode = 7'h66; // f, 7'd102
            8'h34: asciicode = 7'h67; // g, 7'd103
            8'h33: asciicode = 7'h68; // h, 7'd104
            8'h43: asciicode = 7'h69; // i, 7'd105
            8'h3B: asciicode = 7'h6A; // j, 7'd106
            8'h42: asciicode = 7'h6B; // k, 7'd107
            8'h4B: asciicode = 7'h6C; // l, 7'd108
            8'h3A: asciicode = 7'h6D; // m, 7'd109
            8'h31: asciicode = 7'h6E; // n, 7'd110
            8'h44: asciicode = 7'h6F; // o, 7'd111
            8'h4D: asciicode = 7'h70; // p, 7'd112
            8'h15: asciicode = 7'h71; // q, 7'd113
            8'h2D: asciicode = 7'h72; // r, 7'd114
            8'h1B: asciicode = 7'h73; // s, 7'd115
            8'h2C: asciicode = 7'h74; // t, 7'd116
            8'h3C: asciicode = 7'h75; // u, 7'd117
            8'h2A: asciicode = 7'h76; // v, 7'd118
            8'h1D: asciicode = 7'h77; // w, 7'd119
            8'h22: asciicode = 7'h78; // x, 7'd120
            8'h35: asciicode = 7'h79; // y, 7'd121
            8'h1A: asciicode = 7'h7A; // z, 7'd122

            default: asciicode = 7'h0;

        endcase
    end

endmodule

