`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/07 14:08:53
// Design Name: 
// Module Name: day
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


module day(
    input [4:0] state,
    input is_modify,
    input i_plus,
    input i_minus,
    input i_enable,
    input i_clk_0_001s,
    output reg o_enable,
    output reg[14:0] o_day
    );
    
    wire reset = 1;
    
    reg r_enable = 0;
    reg r_enable_falling = 0;
    
    initial
    begin
        o_day <= 8;
        o_enable <= 0;
    end
    
//**************** Calculate the  r_enable_falling ****************//  
  
    always @(posedge i_clk_0_001s, negedge reset)
    begin
        if (reset == 0)
        begin
            r_enable <= 0;
            r_enable_falling <= 0;
        end
        else
        begin
            r_enable <= i_enable;
            r_enable_falling <= r_enable & (~i_enable);
        end
    end    
//**************** Calculate the  r_plus_falling ****************//  
    
    reg r_plus = 0;
    reg r_plus_falling = 0;

    always @(posedge i_clk_0_001s, negedge reset)
    begin
        if (reset == 0)
        begin
            r_plus <= 0;
            r_plus_falling <= 0;
        end
        else
        begin
            r_plus <= i_plus;
            r_plus_falling <= r_plus & (~i_plus);
        end
    end    

//**************** Calculate the  r_minus_falling ****************//
    
    reg r_minus = 0;
    reg r_minus_falling = 0;
    
    always @(posedge i_clk_0_001s, negedge reset)
    begin
        if (reset == 0)
        begin
            r_minus <= 0;
            r_minus_falling <= 0;
        end
        else
        begin
            r_minus <= i_minus;
            r_minus_falling <= r_minus & (~i_minus);
        end
    end        
    
    
    
//************************ Set the minute *******************************//    
    
    
    always @(posedge i_clk_0_001s, negedge reset)
    begin
        if (reset == 0)
        begin
            o_day <= 0;
            r_enable <= 0;
        end
        else
        begin
            if (r_enable_falling == 1)
            begin
                if (o_day == 30)
                begin
                    o_day <= 0;
                    o_enable <= 1;
                end
                else
                begin
                    o_day <= o_day + 1;
                    o_enable <= 0;
                end
            end
            else if (r_minus_falling == 1 && is_modify == 1 && state == 6)
            begin
                if (o_day == 0)
                    o_day <= 30;
                else
                    o_day <= o_day - 1;
                o_enable <= 0;
            end
            else if (r_plus_falling == 1 && is_modify == 1 && state == 6)
            begin
                if (o_day == 30)
                    o_day <= 0;
                else
                    o_day <= o_day + 1;
                o_enable <= 0;
            end
            else
            begin
                o_day <= o_day;
                o_enable <= 0;
            end
        end    
    end
    
endmodule
    
    
