`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2021 21:46:09
// Design Name: 
// Module Name: ReLu
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


module ReLu  #(parameter dataWidth=16,weightIntWidth=4) (
    input           clk,
    input   [2*dataWidth-1:0]   ReLu_Input,
    input relu_data_valid_In,
    output reg relu_data_valid_Out,
    output  reg [dataWidth+3:0]  out
);


always @(posedge clk)
begin
    relu_data_valid_Out <= relu_data_valid_In;
    if($signed(ReLu_Input) >= 0)
    begin
        if(|ReLu_Input[2*dataWidth-1-:weightIntWidth+1]) //over flow to sign bit of integer part
            out <= {1'b0,{(dataWidth+3){1'b1}}}; //positive saturate
        else
            out <= ReLu_Input[2*dataWidth-2-weightIntWidth-:dataWidth+4];
    end
    else 
        out <= 0;      
end
endmodule
