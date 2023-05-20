//***************************************************************
// Description: 
// File Name: fsm.v
// Author: Haoran Geng
// Email: 
// Created Time: Sun 05 Mar 2023 03:31:00 PM CST
// Revision history:
//***************************************************************

module seq_detector(
    input clk_i,
    input rst_n,
    input a_i,
    output flag_o
);

    // one-hot or binary?
    localparam S0=9'b000000001;
    localparam S1=9'b000000010;
    localparam S2=9'b000000100;
    localparam S3=9'b000001000;
    localparam S4=9'b000010000;
    localparam S5=9'b000100000;
    localparam S6=9'b001000000;
    localparam S7=9'b010000000;
    localparam S8=9'b100000000;

    reg  [8:0]  state_next ;
    reg  [8:0]  state_cur  ;
    reg         flag       ;

    always @* begin
        case(state_cur)
            S0: state_next = (a_i == 1'b1) ? S5 : S1;
            S1: state_next = (a_i == 1'b1) ? S0 : S2;
            S2: state_next = (a_i == 1'b1) ? S0 : S3;
            S3: state_next = (a_i == 1'b1) ? S0 : S4;
            S4: state_next = (a_i == 1'b1) ? S0 : S4;
            S5: state_next = (a_i == 1'b1) ? S6 : S0;
            S6: state_next = (a_i == 1'b1) ? S7 : S0;
            S7: state_next = (a_i == 1'b1) ? S8 : S0;
            S8: state_next = (a_i == 1'b1) ? S8 : S0;
            default: state_next = S0;
        endcase
    end

    always @(posedge clk_i, negedge rst_n) begin
        if(!rst_n) begin
            state_cur <= S0;
        end else begin
            state_cur <= state_next;
        end
    end

    always @* begin
        case(state_next)
            S4: flag = 1'b1;
            S8: flag = 1'b1;
            default: flag = 1'b0;
        endcase
    end

    assign flag_o = flag;

endmodule

