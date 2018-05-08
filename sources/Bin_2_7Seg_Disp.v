`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/17 14:20:19
// Design Name: 
// Module Name: Bin_2_7Seg_Disp
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


module Bin_2_7Seg_Disp(
    input [3:0] B,
    output reg[6:0] a_2_g
    );
    
    always @(*)
    begin
    case(B)
    4'b0000:a_2_g=7'h3f;
    4'b0001:a_2_g=7'h86;
    4'b0010:a_2_g=7'h5b;
    4'b0011:a_2_g=7'h4f;    
    4'b0100:a_2_g=7'h66;
    4'b0101:a_2_g=7'h6d;    
    4'b0110:a_2_g=7'h7d;
    4'b0111:a_2_g=7'h07;   
    
    4'b1000:a_2_g=7'h7f;
    4'b1001:a_2_g=7'h6f;
    4'b1010:a_2_g=7'h77;
    4'b1011:a_2_g=7'h7c;    
    4'b1100:a_2_g=7'h39;
    4'b1101:a_2_g=7'h5e;    
    4'b1110:a_2_g=7'h79;
    4'b1111:a_2_g=7'h71;    
   default:a_2_g=7'h00; 
    endcase
    end
    
    
    
    
    
    
    
    
    
    
    
endmodule
