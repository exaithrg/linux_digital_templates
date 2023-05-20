//***************************************************************
// File Name: key_disp_fsm.v
// Author: Haoran Geng
// Email: 
// Created Time: 23.5.19
// Description: 
// Revision history:
//***************************************************************

module key_disp_fsm(
    input        clk_i         ,
    input        rst_n         ,

    input [7:0]  key           ,
    input        key_ready     ,
    input        key_overflow  ,

    output       nextdata_n    ,

    output [7:0] low_keycode   ,
    output [1:0] low_ena       ,
    output [7:0] mid_asciicode ,
    output [1:0] mid_ena       ,
    output [7:0] high_keycnt
);

    parameter IDLE_STATE = 3'b001;
    parameter DISP_STATE = 3'b010;
    parameter END_STATE  = 3'b100;

    wire        key_end            ;
    reg [2:0]   state_ns, state_cs ;

    reg  [7:0] low_keycode_r   ;
    reg  [1:0] low_ena_r       ;
    wire [6:0] asciicode       ;
    reg  [1:0] mid_ena_r       ;
    reg  [1:0] keycnt_ena      ;
    wire [3:0] keycnt [1:0]    ;

    assign key_end = (key == 8'hf0) ? 1'b1 : 1'b0;
    assign nextdata_n = 1'b0;
    
    always @* begin
        state_ns = IDLE_STATE;
        case(state_cs)
            IDLE_STATE: begin
                if(key_ready && ~key_end) state_ns = DISP_STATE;
                else state_ns = IDLE_STATE;
            end
            DISP_STATE: begin
                if(key_ready && key_end) state_ns = END_STATE;
                else state_ns = DISP_STATE;
            end
            END_STATE: begin
                if(key_ready && ~key_end) state_ns = IDLE_STATE;
                else state_ns = END_STATE;
            end
            default: begin
                state_ns = IDLE_STATE;
            end
        endcase
    end

    always @(posedge clk_i, negedge rst_n) begin
        if(!rst_n) begin
            state_cs <= IDLE_STATE;
        end else begin
            state_cs <= state_ns;
        end
    end

    always @(posedge clk_i, negedge rst_n) begin
        if(!rst_n) begin
            low_keycode_r <= 8'b0;
            low_ena_r <= 2'b00;
            mid_ena_r <= 2'b00;
        end else if(state_ns == DISP_STATE) begin
            low_ena_r <= 2'b11;
            mid_ena_r <= 2'b11;
            if(key_ready) low_keycode_r <= key;
        end else begin
            low_keycode_r <= 8'b0;
            low_ena_r <= 2'b00;
            mid_ena_r <= 2'b00;
        end
    end

    // high_keycnt is a BCD counter
    always @* begin
        if(state_ns == DISP_STATE && state_cs == IDLE_STATE) begin
            keycnt_ena[0] = 1'b1;
            if(keycnt[0] == 4'b1001) keycnt_ena[1] = 1'b1;
            else keycnt_ena[1] = 1'b0;
        end else begin
            keycnt_ena = 2'b00;
        end
    end

    bcd_counter u_keycnt1(
        .clk_i ( clk_i         ) ,
        .rst_n ( rst_n         ) ,
        .ena   ( keycnt_ena[1] ) ,
        .cnt   ( keycnt[1]     )
    );
    bcd_counter u_keycnt0(
        .clk_i ( clk_i         ) ,
        .rst_n ( rst_n         ) ,
        .ena   ( keycnt_ena[0] ) ,
        .cnt   ( keycnt[0]     )
    );

    keycode2ascii u_k2a(
        .keycode   ( low_keycode_r ) ,
        .asciicode ( asciicode     )
    );

    assign low_keycode   = low_keycode_r         ;
    assign low_ena       = low_ena_r             ;
    assign mid_asciicode = {1'b0, asciicode}     ;
    assign mid_ena       = mid_ena_r             ;
    assign high_keycnt   = {keycnt[1],keycnt[0]} ;

endmodule

