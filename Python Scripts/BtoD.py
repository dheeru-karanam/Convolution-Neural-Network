def BtoD(num, Data_width, Frac_width):
    num_list = []
    num = str(bin(num))[2:]
    num_list = [int(i) for i in num]
#    print(num_list)
    if(len(num_list)<Data_width):
        num_list = (Data_width-len(num))*"0" + num
    num_list = [int(i) for i in num_list]

    if(num_list[0]==1):
        for i in range(len(num_list)-1,0,-1):
            if(num_list[i]!=0):
                break
                
        for i in range(i-1,0,-1):
            if(num_list[i]==0):
                num_list[i]=1
            else:
                num_list[i]=0

    Frac_Bits = num_list[len(num_list)-Frac_width:]
    Integral_Bits = num_list[1:len(num_list)-Frac_width]
#    print(num_list)
    Integral_Bits_Sum=0.0
#    print(Frac_Bits, Integral_Bits)

    for i in range(0,len(Integral_Bits)):
        Integral_Bits_Sum += Integral_Bits[i]*2**(len(Integral_Bits)-i-1)
#    print(Integral_Bits_Sum)
    Frac_Bits_Sum = 0.0

    for i in range(1,len(Frac_Bits)):
        Frac_Bits_Sum += Frac_Bits[i-1]*2**(-i)
#    print(Frac_Bits_Sum)

    if(num_list[0]==1):
        return -(Integral_Bits_Sum+Frac_Bits_Sum)
    else:
        return (Integral_Bits_Sum+Frac_Bits_Sum)
  

print(BtoD(0b1110111110101011,24,20))