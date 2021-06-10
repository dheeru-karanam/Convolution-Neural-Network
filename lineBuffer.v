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


module lineBuffer #(parameter dataWidth=8, imageWidth=512)(
input   i_clk,
input   [dataWidth-1:0] i_data,
input   i_data_valid,
output  [dataWidth-1:0] o_data,
output  o_data_valid
);

wire [dataWidth-1:0] w_data_out [imageWidth-1:0];
wire [imageWidth-1:0] w_data_valid;

assign o_data = w_data_out[imageWidth-1];
assign o_data_valid = w_data_valid[imageWidth-1];

generate
    genvar i;
    for(i=0;i<imageWidth;i=i+1)
    begin:loop
        if(i==0)
            dataReg #(.dataWidth(dataWidth))DR0(
                .i_clk(i_clk),
                .i_data(i_data),
                .i_data_valid(i_data_valid),
                .o_data(w_data_out[i]),
                .o_data_valid(w_data_valid[i])
            );
         else
            dataReg #(.dataWidth(dataWidth))DR(
                .i_clk(i_clk),
                .i_data(w_data_out[i-1]),
                .i_data_valid(i_data_valid),
                .o_data(w_data_out[i]),
                .o_data_valid(w_data_valid[i])
            );
    end
endgenerate


endmodule