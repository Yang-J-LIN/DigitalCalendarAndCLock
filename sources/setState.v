`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/06 22:27:57
// Design Name: 
// Module Name: setState
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

// This module is to determine wheher to modify the date and time or not, and also, which one to be modified.
// Input functions:
// |-control: control is connected to the control button. Pressing of the control button will have the output 0_state toggled.
// |-left: left is connected to the left button. Pressing of the left button will rotate the modified bit once to the left.
// |-right: right is connected to the right button. Pressing of the left button will rotate the modified bit once to the right.
// |-i_clk_0_001s: i_clk_0_001s is a clock signal whose period is millisecond.
// |-timer_17: A signal that halve the 50Hz signal 17 times.

module setState(
    input control,
    input left,
    input right,
    input i_clk_0_001s,
    input timer_17,
    output [4:0] o_state,
    output o_is_modify
    );
    
    wire w_left;
    wire w_right;
    wire w_control;
    
    wire reset = 1;
    
    reg is_modify = 0;
    reg [4:0] state = 0;
    
    reg r_left;
    reg r_left_falling;
    
    reg r_right;
    reg r_right_falling;
    
    reg r_control;
    reg r_control_falling;
    
    assign w_left = left;
    assign w_right = right;
    assign w_control = control;
    
    always @(posedge i_clk_0_001s, negedge reset)
    begin
        if (reset == 0)
        begin
            r_left <= 0;
            r_left_falling <= 0;
        end
        else
        begin
            r_left <= w_left;
            r_left_falling <= r_left & (~w_left);
        end
    end        

    always @(posedge i_clk_0_001s, negedge reset)
    begin
        if (reset == 0)
        begin
            r_right <= 0;
            r_right_falling <= 0;
        end
        else
        begin
            r_right <= w_right;
            r_right_falling <= r_right & (~w_right);
        end
    end    

    always @(posedge i_clk_0_001s, negedge reset)
    begin
        if (reset == 0)
        begin
            r_control <= 0;
            r_control_falling <= 0;
        end
        else
        begin
            r_control <= w_control;
            r_control_falling <= r_control & (~w_control);
        end
    end    
    
    always @(posedge i_clk_0_001s, negedge reset)
    begin
        if (reset == 0)
        begin
            state = 0;
            is_modify = 0;
        end
        else
        begin
            if (r_control_falling == 1)
                is_modify = !is_modify;
            
            if (r_right_falling == 1 && is_modify == 1)
            begin
                if (state == 6)
                    state = 0;
                else
                    state = state + 1;
            end
            
            if (r_left_falling == 1 && is_modify == 1)
            begin
                if (state == 0)
                    state = 6;
                else
                    state = state - 1;
            end
            if (is_modify == 0)
                state = 0;
            
        end
    end
    
    assign o_is_modify = is_modify;
    assign o_state = state;
    
endmodule
