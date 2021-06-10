`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2021 13:29:04
// Design Name: 
// Module Name: maxPooler
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


module maxPooler(
    input   i_clk,
    input[63:0] i_data_MP,
    input i_data_valid_MP,
    output reg [15:0] out_data_MP,
    output out_data_valid
    );
    
    integer i;
    reg [15:0] largest;
    initial begin
        largest = 16'b0;
    end
    always @(posedge i_clk) begin
        if(i_data_valid_MP)begin
            largest = i_data_MP[15:0];
            for(i=0;i<4;i=i+1)
            begin
                if(i_data_MP[16*i +: 16] > largest)
                    largest = i_data_MP[i*16+:16];
            end
            out_data_MP = largest;
        end
    end
 maxpoolLogic  #(.imageWidth(26)) MDL(
    .i_clk(i_clk),
    .i_reset_n(),
    .i_data_valid(i_data_valid_MP),
    .o_data_valid(out_data_valid)
 );
endmodule
