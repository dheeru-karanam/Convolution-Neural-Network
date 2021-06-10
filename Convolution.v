`timescale 1ns / 1ps

module Convolution #(parameter ConvData=1)(
input i_clk,
input i_data_valid,
input [71:0]i_data,
output reg o_data_valid,
output reg [23:0]o_data
    );
  
  integer i;
  reg [15:0] coeff[26:0];reg [23:0]bias[2:0];
  reg [23:0] sum,mul;reg [23:0] BiasAdd,x;

  initial 
  begin
  coeff[0]=16'b1001011101000;	coeff[1]=16'b1010001110000;	coeff[2]=16'b111011010110;
  coeff[3]=16'b1100100101010;    coeff[4]=16'b11111100;    coeff[5]=16'b1001001111111;
  coeff[6]=16'b1100011011100;    coeff[7]=16'b110010000000;    coeff[8]=16'b1010010110010;
          
  coeff[9]=16'b1110111110101011;    coeff[10]=16'b11100110000;    coeff[11]=16'b1111011100111111;
  coeff[12]=16'b10101010010;    coeff[13]=16'b1100100101011;    coeff[14]=16'b101100111100;
  coeff[15]=16'b100001010000;    coeff[16]=16'b111101000111;    coeff[17]=16'b110011011000;
          
  coeff[18]=16'b1000100101000;    coeff[19]=16'b10110111;    coeff[20]=16'b1101011111000110;
  coeff[21]=16'b1001001010110;    coeff[22]=16'b101110100001;    coeff[23]=16'b1101101111101010;
  coeff[24]=16'b111001110000;    coeff[25]=16'b1001111001100;    coeff[26]=16'b1101111001111011;
          
          
  bias[0]=24'b1011000100;        
  bias[1]=24'b111111111011001001000010;        
  bias[2]=24'b101000010000101;        


  end

always@(posedge i_clk)
o_data_valid <= i_data_valid;

always@(posedge i_clk)
begin
 sum = 0;x=0;
    for(i=9*(ConvData-1);i<(9*ConvData);i=i+1)
    begin
        mul = $signed(i_data[(i-(9*(ConvData-1)))*8+:8])*$signed(coeff[i]);
      /*  if(coeff[i][15]==0)begin
            if(mul[23]==1)begin
                mul = 24'b011111111111111111111111;
            end
        end
        else begin
            if(mul[23]==0)begin
                mul = 24'b100000000000000000000000;
            end
        end */
        x=$signed(x)+$signed(mul);             
        
                 if(!sum[23] &!mul[23] & x[23]) //If bias and sum are positive and after adding bias to sum, if sign bit becomes 1, saturate
              begin
                  x[23] <= 1'b0;
                  x[22:0] <= {23{1'b1}};
              end
          else if(mul[23] & sum[23] &  !x[23]) //If bias and sum are negative and after addition if sign bit is 0, saturate
              begin
                  x[23] <= 1'b1;
                  x[22:0] <= {23{1'b0}};
              end
          else
                  x <= x;
   
    end
    sum =  $signed(x);
    
    BiasAdd <= $signed(sum) + $signed(bias[ConvData-1]); 
         if(!bias[ConvData-1][23] &!sum[23] & BiasAdd[23]) //If bias and sum are positive and after adding bias to sum, if sign bit becomes 1, saturate
               begin
                   o_data[23] <= 1'b0;
                   o_data[22:0] <= {23{1'b1}};
               end
           else if(bias[ConvData-1][23] & sum[23] &  !BiasAdd[23]) //If bias and sum are negative and after addition if sign bit is 0, saturate
               begin
                   o_data[23] <= 1'b1;
                   o_data[22:0] <= {23{1'b0}};
               end
           else
                   o_data <= BiasAdd;
    
 end 

endmodule

