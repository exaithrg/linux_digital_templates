//***************************************************************
// File Name: bcd_counter.v
// Author: Haoran Geng
// Email: 
// Created Time: 2023年05月20日 星期六 21时02分22秒
// Description: 
// Revision history:
//***************************************************************

module bcd_counter(
    input clk_i      ,
    input rst_n      ,
    input ena        ,
    output [3:0] cnt
);

    reg [3:0] cnt_r;

    always @(posedge clk_i, negedge rst_n) begin
        if(!rst_n) begin
            cnt_r <= 4'b0000;
        end else if(ena) begin
            if( cnt_r == 4'b1001 ) cnt_r <= 4'b0000;
            else cnt_r <= cnt_r + 1'b1;
        end
    end

    assign cnt = cnt_r;

endmodule

