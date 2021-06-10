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



module imageBuffer #(parameter dataWidth=1,kernelWidth=5,kernelHeight=5,imageWidth=256)(
input        i_clk,
input  [dataWidth-1:0] i_pixel_data,
input        i_pixel_data_valid,
output [kernelWidth*kernelHeight*dataWidth-1:0] o_data,
output       o_data_valid
);

integer counter=0;
integer outDataCounter=0;
reg data_valid_int;

always @(posedge i_clk)
begin
    if(i_pixel_data_valid & !data_valid_int)
        counter <= counter+1;
    else if(!i_pixel_data_valid & data_valid_int)
        counter <= counter-1;
        
    //if(counter == (((kernelHeight+1)/2)*imageWidth+((kernelWidth+1)/2)) & i_pixel_data_valid)
    //    data_valid_int <= 1'b1;
    if(counter >= (((kernelHeight+1)/2)*imageWidth+(kernelWidth+1)/2))
        data_valid_int <= 1'b1;
    else
        data_valid_int <= 1'b0;
end

always @(posedge i_clk)
begin
    if(outDataCounter==imageWidth-1 & data_valid_int)
        outDataCounter <= 0;
    else if(data_valid_int)
        outDataCounter <= outDataCounter+1;
end

assign o_data_valid = data_valid_int & (outDataCounter<imageWidth-kernelWidth+1);


wire [dataWidth-1:0] w_data_reg_out [kernelWidth*kernelHeight-1:0];
wire [kernelWidth*kernelHeight-1:0] w_data_reg_out_valid;
wire [dataWidth-1:0] line_buff_out [kernelHeight-2:0];
wire [kernelHeight-2:0] line_buff_out_valid;

//assign o_data_valid = i_pixel_data_valid;//w_data_reg_out_valid[`kernelWidth*`kernelHeight-1];

generate
genvar i,j,k;
    for(i=kernelHeight-1;i>=0;i=i-1)
    begin:l1
        for(j=kernelWidth-1;j>=0;j=j-1)
        begin:l2
            for(k=0;k<dataWidth;k=k+1)
            begin:l3
                assign o_data[(kernelHeight-1-i)*kernelWidth*dataWidth+(kernelWidth-1-j)*dataWidth+k] = w_data_reg_out[i*kernelWidth+j][k];
            end
        end
    end
endgenerate



generate
    //genvar i,j;
    for(i=0;i<kernelHeight;i=i+1)
    begin:oloop
        for(j=0;j<kernelWidth;j=j+1)
        begin:iloop
            if(i==0&j==0) //first data register
            begin
                dataReg #(.dataWidth(dataWidth))dR0(
                    .i_clk(i_clk),
                    .i_data(i_pixel_data), //external data
                    .i_data_valid(i_pixel_data_valid),
                    .o_data(w_data_reg_out[i*kernelWidth+j]),
                    .o_data_valid(w_data_reg_out_valid[i*kernelWidth+j])
                );
            end
            else if(j==0) //first data register in each row
            begin
                dataReg #(.dataWidth(dataWidth))dR1(
                    .i_clk(i_clk),
                    .i_data(line_buff_out[i-1]), //data out from each line
                    .i_data_valid(i_pixel_data_valid),
                    .o_data(w_data_reg_out[i*kernelWidth+j]),
                    .o_data_valid(w_data_reg_out_valid[i*kernelWidth+j])
                );
            end
            else//all other cases
            begin
                dataReg #(.dataWidth(dataWidth))dR2(
                    .i_clk(i_clk),
                    .i_data(w_data_reg_out[i*kernelWidth+j-1]), //data out previous data reg
                    .i_data_valid(i_pixel_data_valid),
                    .o_data(w_data_reg_out[i*kernelWidth+j]),
                    .o_data_valid(w_data_reg_out_valid[i*kernelWidth+j])
                );
            end
        end
    end
endgenerate


generate
//genvar i,j;
    for(i=0;i<kernelHeight-1;i=i+1)
    begin:loop
        if(i==0)
        begin
            lineBuffer #(.dataWidth(dataWidth),.imageWidth(imageWidth-kernelWidth))lB0(
                .i_clk(i_clk),
                .i_data(w_data_reg_out[kernelWidth-1]),
                .i_data_valid(i_pixel_data_valid),
                .o_data(line_buff_out[i]),
                .o_data_valid(line_buff_out_valid[i])
            );
        end
        else
        begin
            lineBuffer #(.dataWidth(dataWidth),.imageWidth(imageWidth-kernelWidth))lB(
                .i_clk(i_clk),
                .i_data(w_data_reg_out[(i+1)*kernelWidth-1]),
                .i_data_valid(i_pixel_data_valid),
                .o_data(line_buff_out[i]),
                .o_data_valid(line_buff_out_valid[i])
            );        
        end
    end
endgenerate


endmodule