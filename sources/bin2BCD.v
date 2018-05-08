`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/24 02:44:43
// Design Name: 
// Module Name: bin2BCD
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


module bin2BCD(
    input [14:0] binary,
    output reg[3:0] ten,
    output reg[3:0] one,
    output reg[3:0] hund,
    output reg[3:0] thou
    );
    
    integer i;
        
          always @(*)
          begin
              ten = 4'd0;
              one = 4'd0;
              hund = 4'd0;
              thou = 4'd0;
              
              for (i=14; i>=0; i=i-1)
              begin
                  if(thou >= 5)
                      thou = thou + 3;
                  if(hund >= 5)
                      hund = hund + 3;
                  if(ten >= 5)
                      ten = ten + 3;
                  if(one >= 5)
                      one = one + 3;
                  
                  
                  thou = thou << 1;
                  thou[0] = hund[3];
                  hund = hund << 1;
                  hund[0] = ten[3];
                  ten = ten << 1;
                  ten[0] = one[3];
                  one = one << 1;
                  one[0] = binary[i];
              end
        
    end

endmodule
