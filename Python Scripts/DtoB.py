def DtoB(num,dataWidth,fracBits):   #funtion for converting into two's complement format
    if num >= 0:
        num = num * (2**fracBits)
        num = int(num)
        if num == 0:
            d = 0
        else:
            d = num
    else:
        num = -num
        num = num * (2**fracBits)    #number of fractional bits
        num = int(num)
        if num == 0:
            d = 0
        else:
            d = 2**dataWidth - num
    #print(d)        
    return (d)
    
print(f"0.000675429,{bin(DtoB(0.000675429,24,20))}")


print(f"-0.018980358,{bin(DtoB(-0.018980358,24,20))}")
print(f"0.019658484,{bin(DtoB(0.019658484,24,20))}")
#print(f"0.786429584,{bin(DtoB(0.786429584,16,13))}")
#print(f"0.030792372,{bin(DtoB(0.030792372,16,13))}")
#print(f"0.578017294,{bin(DtoB(0.578017294,16,13))}")
#print(f"0.7769171,{bin(DtoB(0.451235,16,13))}")
#print(f"0.390625536,{bin(DtoB(0.390625536,16,13))}")
#print(f"0.64675492,{bin(DtoB(0.64675492,16,13))}") 
#print(f"-0.0189803577959538,{bin(DtoB(-0.0189803577959538,24,20))}") 
#print(f"-0.25,{bin(DtoB(-0.25,24,20))}") 

		
		#23'b11111111111111111111111
 
'''  
print(f"0.099249501,{hex(DtoB(0.099249501,16,13))}")
print(f"0.217330235,{hex(DtoB(0.217330235,16,13))}")
print(f"0.221893474,{hex(DtoB(0.099249501,16,13))}")
print(f"0.122657344,{hex(DtoB(0.122657344,16,13))}")
print(f"0.186424709,{hex(DtoB(0.186424709,16,13))}")
print(f"0.346252891,{hex(DtoB(0.346252891,16,13))}")
print(f"0.312578263,{hex(DtoB(0.312578263,16,13))}")
print(f"0.035602017,{hex(DtoB(0.035602017,16,13))}")
print(f"0.316546654,{hex(DtoB(0.316546654,16,13))}")
print(f"0.344884302,{hex(DtoB(0.344884302,16,13))}")
print(f"0.235524086,{hex(DtoB(0.235524086,16,13))}")
print(f"0.040378428,{hex(DtoB(0.040378428,16,13))}")
print(f"0.32846124,{hex(DtoB(0.32846124,16,13))}")
print(f"0.072692619,{hex(DtoB(0.072692619,16,13))}")
print(f"0.198106664,{hex(DtoB(0.198106664,16,13))}")
print(f"0.224448514,{hex(DtoB(0.224448514,16,13))}")
print(f"0.071273862,{hex(DtoB(0.071273862,16,13))}")
print(f"0.302838213,{hex(DtoB(0.302838213,16,13))}")

print(f"0.125910142,{hex(DtoB(0.125910142,16,13))}")
print(f"0.154150446,{hex(DtoB(0.154150446,16,13))}")
print(f"0.319241949,{hex(DtoB(0.319241949,16,13))}")
print(f"0.315295482,{hex(DtoB(0.315295482,16,13))}")
print(f"0.114961434,{hex(DtoB(0.114961434,16,13))}")
print(f"0.188958611,{hex(DtoB(0.188958611,16,13))}")

print(f"0.317980123,{hex(DtoB(0.317980123,16,13))}")
print(f"0.261495062,{hex(DtoB(0.261495062,16,13))}")
print(f"0.145136015,{hex(DtoB(0.145136015,16,13))}")
print(f"0.343109057,{hex(DtoB(0.343109057,16,13))}")
print(f"0.273492726,{hex(DtoB(0.273492726,16,13))}")
print(f"0.154150446,{hex(DtoB(0.154150446,16,13))}")


print(f"0.252365177,{hex(DtoB(0.252365177,16,13))}")
print(f"0.07882387,{hex(DtoB(0.07882387,16,13))}")
'''