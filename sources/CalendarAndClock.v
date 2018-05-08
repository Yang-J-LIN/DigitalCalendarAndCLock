`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/06 18:05:35
// Design Name: 
// Module Name: CalendarAndClock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CalendarAndClock(
    input up,
    input down,
    input left,
    input right,
    input control,
    input switch,
    input clk,
    output reg [7:0] a_2_g,
    output reg [7:0] a_2_g_2,
    output reg [3:0] bit,
    output reg [3:0] bit_2
    );
    
    wire [14:0] w_centisecond;
    wire [14:0] w_second;
    wire [14:0] w_minute;
    wire [14:0] w_hour;
    wire [14:0] w_day;
    wire [14:0] w_month;
    wire [14:0] w_year;
    
    wire w_centisecond_carry;
    wire w_second_carry;
    wire w_minute_carry;
    wire w_hour_carry;
    wire w_day_carry;
    wire w_month_carry;
    wire w_year_carry;
    
    wire w_up;
    wire w_down;
    wire w_left;
    wire w_right;
    wire w_control;
    
    reg [20:0] timer;
    reg [30:0] timer_3 = 0;
    reg [3:0] timer_2;
    reg r_ms = 0;
    reg r_cs = 0;
    
    wire [4:0] state;
    wire is_modify;
    
    wire reset = 1;
    
/**************** Frequency devider *****************/
// The frequency of clk is 50MHz. 
 
    always @(posedge clk, negedge reset)
    begin
    if (reset == 0)
    begin
        timer <= 0;
        timer_3 <= 0;
    end
    else if (timer == 25000)
    begin
        timer <= 0;
        r_ms <= ~r_ms;
        timer_3 <= timer_3 + 1;
    end
    else
    begin
        timer <= timer + 1;
        timer_3 <= timer_3 + 1;
    end
    end
    
    setState(.left(left), .right(right), .control(control), .i_clk_0_001s(r_cs), .timer_17(timer[17]), .o_state(state), .o_is_modify(is_modify));
    
    always @(posedge r_ms, negedge reset)
    begin
        if (reset == 0)
            timer_2 <= 0;
        else if (timer_2 == 9)
        begin
            timer_2 <= 0;
            r_cs <= ~r_cs;
        end
        else
            timer_2 <= timer_2 + 1;
    end
        
    assign w_up = up;
    assign w_down = down;
    
    centisecond(.state(state),
                .is_modify(is_modify),
                .i_plus(w_up),
                .i_minus(w_down),
                .i_enable(r_cs),
                .i_clk_0_001s(r_ms),
                .o_enable(w_centisecond_carry),
                .o_centisecond(w_centisecond));

    second(.state(state),
                .is_modify(is_modify),
                .i_plus(w_up),
                .i_minus(w_down),
                .i_enable(w_centisecond_carry),
                .i_clk_0_001s(r_ms),
                .o_enable(w_second_carry),
                .o_second(w_second));
                
    minute(.state(state),
                .is_modify(is_modify),
                .i_plus(w_up),
                .i_minus(w_down),
                .i_enable(w_second_carry),
                .i_clk_0_001s(r_ms),
                .o_enable(w_minute_carry),
                .o_minute(w_minute));    

    hour(.state(state),
                .is_modify(is_modify),
                .i_plus(w_up),
                .i_minus(w_down),
                .i_enable(w_minute_carry),
                .i_clk_0_001s(r_ms),
                .o_enable(w_hour_carry),
                .o_hour(w_hour));  

    day(.state(state),
                .is_modify(is_modify),
                .i_plus(w_up),
                .i_minus(w_down),
                .i_enable(w_hour_carry),
                .i_clk_0_001s(r_ms),
                .o_enable(w_day_carry),
                .o_day(w_day));  

    month(.state(state),
                .is_modify(is_modify),
                .i_plus(w_up),
                .i_minus(w_down),
                .i_enable(w_day_carry),
                .i_clk_0_001s(r_ms),
                .o_enable(w_month_carry),
                .o_month(w_month));  

    year(.state(state),
                .is_modify(is_modify),
                .i_plus(w_up),
                .i_minus(w_down),
                .i_enable(w_month_carry),
                .i_clk_0_001s(r_ms),
                .o_enable(w_year_carry),
                .o_year(w_year));
    
    wire [6:0] w_centisecond_low;
    wire [6:0] w_centisecond_high;
    wire [6:0] w_second_low;
    wire [6:0] w_second_high;
    wire [6:0] w_minute_low;
    wire [6:0] w_minute_high;
    wire [6:0] w_hour_low;
    wire [6:0] w_hour_high;
    
    wire [6:0] w_centisecond_low_2;
    wire [6:0] w_centisecond_high_2;
    wire [6:0] w_second_low_2;
    wire [6:0] w_second_high_2;
    wire [6:0] w_minute_low_2;
    wire [6:0] w_minute_high_2;
    wire [6:0] w_hour_low_2;
    wire [6:0] w_hour_high_2;
    
    wire [6:0] w_day_low;
    wire [6:0] w_day_high;
    wire [6:0] w_month_low;
    wire [6:0] w_month_high;
    wire [6:0] w_year_0;
    wire [6:0] w_year_1;
    wire [6:0] w_year_2;
    wire [6:0] w_year_3;

    wire [6:0] w_day_low_2;
    wire [6:0] w_day_high_2;
    wire [6:0] w_month_low_2;
    wire [6:0] w_month_high_2;
    wire [6:0] w_year_0_2;
    wire [6:0] w_year_1_2;
    wire [6:0] w_year_2_2;
    wire [6:0] w_year_3_2;
    
    bin2BCD(.binary(w_centisecond), .ten(w_centisecond_high), .one(w_centisecond_low));
    bin2BCD(.binary(w_second), .ten(w_second_high), .one(w_second_low));   
    bin2BCD(.binary(w_minute), .ten(w_minute_high), .one(w_minute_low));
    bin2BCD(.binary(w_hour), .ten(w_hour_high), .one(w_hour_low));
    
    bin2BCD(.binary(w_day), .ten(w_day_high), .one(w_day_low));
    bin2BCD(.binary(w_month), .ten(w_month_high), .one(w_month_low));
    bin2BCD(.binary(w_year), .thou(w_year_3), .hund(w_year_2), .ten(w_year_1), .one(w_year_0));
    
    Bin_2_7Seg_Disp(.B(w_centisecond_low), .a_2_g(w_centisecond_low_2));
    Bin_2_7Seg_Disp(.B(w_centisecond_high), .a_2_g(w_centisecond_high_2));
    Bin_2_7Seg_Disp(.B(w_second_low), .a_2_g(w_second_low_2));
    Bin_2_7Seg_Disp(.B(w_second_high), .a_2_g(w_second_high_2));
    Bin_2_7Seg_Disp(.B(w_minute_low), .a_2_g(w_minute_low_2));
    Bin_2_7Seg_Disp(.B(w_minute_high), .a_2_g(w_minute_high_2));
    Bin_2_7Seg_Disp(.B(w_hour_low), .a_2_g(w_hour_low_2));
    Bin_2_7Seg_Disp(.B(w_hour_high), .a_2_g(w_hour_high_2));

    Bin_2_7Seg_Disp(.B(w_day_low), .a_2_g(w_day_low_2));
    Bin_2_7Seg_Disp(.B(w_day_high), .a_2_g(w_day_high_2));
    Bin_2_7Seg_Disp(.B(w_month_low), .a_2_g(w_month_low_2));
    Bin_2_7Seg_Disp(.B(w_month_high), .a_2_g(w_month_high_2));
    Bin_2_7Seg_Disp(.B(w_year_3), .a_2_g(w_year_3_2));
    Bin_2_7Seg_Disp(.B(w_year_2), .a_2_g(w_year_2_2));
    Bin_2_7Seg_Disp(.B(w_year_1), .a_2_g(w_year_1_2));
    Bin_2_7Seg_Disp(.B(w_year_0), .a_2_g(w_year_0_2));    
    
    
    always @(*)
    begin
    
    // Control the higher 7-Seg LED Nixietube.
    // When is_modify is false, switch is used to determine whether the date or the time to be displayed.
    // When is_modify is true, the operating bit is flashed to indicate the state of editing.
    // - year
    // - hour
    // - minute
    
    if (((switch == 0) && !is_modify) || (is_modify && (state < 4)))
    begin
        if (!(is_modify && timer_3[25] == 1 && timer_3[26] == 1 && state == 0))
        begin
            if (timer_3[19] == 1 && timer_3[18] == 1)
            begin
                bit <= 8;
                a_2_g <= w_hour_high_2;
            end
            if (timer_3[19] == 0 && timer_3[18] == 1)
            begin
                bit <= 4;
                a_2_g <= w_hour_low_2 + 8'b10000000;  // + 8'b10000000 to light the decimal point.
            end
        end
    else
    begin
        bit <= 4;
        a_2_g <= 8'b10000000;
    end
    
    if (!(is_modify && timer_3[25] == 1 && timer_3[26] == 1 && state == 1))
    begin
        if (timer_3[19] == 1 && timer_3[18] == 0)
        begin
            bit <= 2;
            a_2_g <= w_minute_high_2;
        end
        if (timer_3[19] == 0 && timer_3[18] == 0)
        begin
            bit <= 1;
            a_2_g <= w_minute_low_2 + 8'b10000000;
        end
    end
    else if (is_modify && state == 1 && timer_3[18] == 0)
    begin
        bit <= 1;
        a_2_g <= 8'b10000000;
    end
    end
    else if (((switch == 1) && !is_modify) || (is_modify && (state > 3)))
    begin
        if (!(is_modify && timer_3[25] == 1 && timer_3[26] == 1 && state == 4))  
        begin
            if (timer_3[19] == 1 && timer_3[18] == 1)
            begin
                bit <= 8;
                a_2_g <= w_year_3_2;
            end
            if (timer_3[19] == 0 && timer_3[18] == 1)
            begin
                bit <= 4;
                a_2_g <= w_year_2_2;
            end
            if (timer_3[19] == 1 && timer_3[18] == 0)
            begin
                bit <= 2;
                a_2_g <= w_year_1_2;
            end
            if (timer_3[19] == 0 && timer_3[18] == 0)
            begin
                bit <= 1;
                a_2_g <= w_year_0_2 + 8'b10000000;
            end
        end
        else
        begin
            bit <= 1;
            a_2_g <= 8'b10000000;
        end
    end
    end

    always @(*)
    begin
    if (((switch == 0) && !is_modify) || (is_modify && (state < 4)))    
    begin
    if (!(is_modify && timer_3[25] == 1 && timer_3[26] == 1 && state == 2))
    begin
        if (timer_3[18] == 1 && timer_3[19] == 1)
        begin
            bit_2 <= 8;
            a_2_g_2 <= w_second_high_2;
        end
        if (timer_3[18] == 0 && timer_3[19] == 1 )
        begin
            bit_2 <= 4;
            a_2_g_2 <= w_second_low_2 + 8'b10000000;
        end
    end
    else
    begin
        bit_2 <= 4;
        a_2_g_2 <= 8'b10000000;
    end
    
    if (!(is_modify && timer_3[25] == 1 && timer_3[26] == 1 && state == 3))
    begin
        if (timer_3[18] == 1 && timer_3[19] == 0)
        begin
            bit_2 <= 2;
            a_2_g_2 <= w_centisecond_high_2;
        end
        if (timer_3[18] == 0 && timer_3[19] == 0)
        begin
            bit_2 <= 1;
            a_2_g_2 <= w_centisecond_low_2;
        end
    end
    end
    else if (((switch == 1) && !is_modify) || (is_modify && (state > 3)))    
        begin
        if (!(is_modify && timer_3[25] == 1 && timer_3[26] == 1 && state == 5))
        begin
            if (timer_3[18] == 1 && timer_3[19] == 1)
            begin
                bit_2 <= 8;
                a_2_g_2 <= w_month_high_2;
            end
            if (timer_3[18] == 0 && timer_3[19] == 1)
            begin
                bit_2 <= 4;
                a_2_g_2 <= w_month_low_2 + 8'b10000000;
            end
        end
        else
        begin
            bit_2 <= 4;
            a_2_g_2 <= 8'b10000000;
        end
            
        if (!(is_modify && timer_3[25] == 1 && timer_3[26] == 1 && state == 6))
        begin
            if (timer_3[18] == 1 && timer_3[19] == 0)
            begin
                bit_2 <= 2;
                a_2_g_2 <= w_day_high_2;
            end
            if (timer_3[18] == 0 && timer_3[19] == 0)
            begin
                bit_2 <= 1;
                a_2_g_2 <= w_day_low_2;
            end
        end
    end
    end

endmodule
