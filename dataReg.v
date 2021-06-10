`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2021 21:35:56
// Design Name: 
// Module Name: axi4FIFO
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


module dataReg #(parameter dataWidth=8)(
input i_clk,
input [dataWidth-1:0] i_data,
input i_data_valid,
output reg [dataWidth-1:0] o_data,
output reg o_data_valid
);

initial
    o_data = 0;
    
always @(posedge i_clk)
begin
    if(i_data_valid)
        o_data <= i_data;
    o_data_valid <= i_data_valid;
end

endmodule
