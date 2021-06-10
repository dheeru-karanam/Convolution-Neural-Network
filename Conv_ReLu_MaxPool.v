`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.06.2021 14:16:40
// Design Name: 
// Module Name: Conv_ReLu_MaxPool
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


module Conv_ReLu_MaxPool #(parameter ConvKernel=1)
                           (input[71:0] inputData,
                           input inputValid,
                           input clk,
                           output[15:0] MP_Out,
                           output MPOut_valid
    );
    wire out_data_valid;
    wire[71:0] out_data;
    wire data_conv_valid;
    wire[23:0] conv_data;
    wire relu_data_valid_Out;
    wire[15:0]relu_out;
    wire[63:0] Out;
    wire Out_valid;
    
    Convolution #(.ConvData(ConvKernel))conv (
    .i_clk(clk),
    .i_data_valid(inputValid),
    .i_data(inputData),
    .o_data_valid(data_conv_valid),
    .o_data(conv_data)
        );
    
    ReLu  #(.dataWidth(12),.weightIntWidth(0)) ReLu 
        (.clk(clk), 
        .ReLu_Input(conv_data),
        .relu_data_valid_In(data_conv_valid),
        .relu_data_valid_Out(relu_data_valid_Out),
        .out(relu_out));

     imageBuffer2 #(.dataWidth(16),.kernelWidth(2),.kernelHeight(2),.imageWidth(26)) IB2 (
               . i_clk(clk),
               .i_pixel_data(relu_out),
               .i_pixel_data_valid(relu_data_valid_Out),
               .o_data(Out),//connect to max pooler 32 bits wide
               .o_data_valid(Out_valid)//connect to max pooler
             );
        
      maxPooler MP(
                 .i_clk(clk),
                 .i_data_MP(Out),
                 .i_data_valid_MP(Out_valid),
                 .out_data_MP(MP_Out),
                 .out_data_valid(MPOut_valid)
                 );
endmodule
