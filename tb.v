`timescale 1ns/1ps

`define imageSize 28*28

module tb();

integer file,file1,file2,file3;

reg clk;

initial
begin
   clk = 0;
   forever
   begin
       clk = ~clk;
       #5;
   end
end

integer i;
reg [7:0] imgData;
reg imgDataValid;

initial
 begin
   file = $fopen("NineInput.hex","r"); //Input File
   file1 = $fopen("MaxPool1.hex","w"); //Output File for Kernel 1
   file2 = $fopen("MaxPool2.hex","w"); //Output File for Kernel 2
   file3 = $fopen("MaxPool3.hex","w"); //Output File for Kernel 3
   imgDataValid = 0;  
   for(i=0;i<256*256;i=i+1)
   begin
        $fscanf(file,"%h",imgData);
        imgDataValid <= 1'b1;
        @(posedge clk);
        #1;
    end
    $fclose(file);
    imgData = 0;
    while(1)
        @(posedge clk);
 end
 
integer receivedDataCount1=0,receivedDataCount2=0,receivedDataCount3=0;

   wire out_data_valid; 
   //  wire [7:0] max_pool_data;

 wire [71:0]out_data; 
  
 imageBuffer #(.dataWidth(8),.kernelWidth(3),.kernelHeight(3),.imageWidth(28)) IB (
    . i_clk(clk),
    .i_pixel_data(imgData),
    .i_pixel_data_valid(imgDataValid),
    .o_data(out_data),//connect to max pooler 32 bits wide
    .o_data_valid(out_data_valid)//connect to max pooler
  );
wire [15:0] MP_Out1;
wire MPOut_valid1;
wire [15:0] MP_Out2;
wire MPOut_valid2;
wire [15:0] MP_Out3;
wire MPOut_valid3;

wire data_conv_valid;wire [23:0]conv_data;
  always @(posedge clk)
  begin
      if(MPOut_valid1)
      begin
          $fwrite(file1,"%.2X\n",MP_Out1);                    
          receivedDataCount1 = receivedDataCount1+1;
      end
      if(receivedDataCount1 ==  13*13) begin
        $fclose(file1);
     end
  end
  always @(posedge clk)
    begin
     if(MPOut_valid2)
                 begin
                     $fwrite(file2,"%.2X\n",MP_Out2);                 
                     receivedDataCount2 = receivedDataCount2+1;
                 end
      if(receivedDataCount2 == 13*13) begin
            $fclose(file2);
       end
  end
  always @(posedge clk)
    begin
       if(MPOut_valid3)
       begin
            $fwrite(file3,"%.2X\n",MP_Out3);                    
            receivedDataCount3 = receivedDataCount3+1;
       end
       if(receivedDataCount3 == 13*13) begin
            $fclose(file3);
       end
   end
   
   always @(posedge clk)
     begin 
        if(receivedDataCount3 == 13*13 && receivedDataCount2 == 13*13 && receivedDataCount1 == 13*13)begin
            $stop;
        end
     end
    wire [63:0] Out;
 
 
 Conv_ReLu_MaxPool #( .ConvKernel(1)) CRM1
                               (.inputData(out_data),
                               .inputValid(out_data_valid),
                               .clk(clk),
                               .MP_Out(MP_Out1),
                               .MPOut_valid(MPOut_valid1)
        );
        Conv_ReLu_MaxPool #( .ConvKernel(2)) CRM2
                                (.inputData(out_data),
                                .inputValid(out_data_valid),
                                .clk(clk),
                                .MP_Out(MP_Out2),
                                .MPOut_valid(MPOut_valid2)
            );
            Conv_ReLu_MaxPool #( .ConvKernel(3)) CRM3
                                (.inputData(out_data),
                                .inputValid(out_data_valid),
                                .clk(clk),
                                .MP_Out(MP_Out3),
                                .MPOut_valid(MPOut_valid3)
                );
endmodule