`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.05.2021 17:10:54
// Design Name: 
// Module Name: madpoolLogic
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


module maxpoolLogic #(parameter imageWidth=256)(
input   i_clk,
input   i_reset_n,
input   i_data_valid,
output o_data_valid
    );
 reg count;
 integer pixelCounter=0;
 reg validInt=1;
 initial count = 1'b0;
 assign o_data_valid = (i_data_valid && (pixelCounter<26) && count);
 
 always @(posedge i_clk)
 begin
    if(i_data_valid && pixelCounter == (2*imageWidth-1))
        pixelCounter <= 0;
    else if(i_data_valid) begin
        pixelCounter <= pixelCounter + 1;
    end
    //else if(pixelCounter<26 && count)
    //    o_data_valid = count;
    //end
    if(i_data_valid)
        count = ~count;
 end
 
 endmodule
