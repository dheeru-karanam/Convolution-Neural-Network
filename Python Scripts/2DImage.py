fh  = open("cameraman1256Processed.hex", "r") #Input File
fh1 = open("may11-12-14-2.hex", "w") #Output File
count = 0
a = fh.readline().rstrip("\n")
while(a!=""):
    fh1.write(a)
    print(a)
    count+=1
    if(count==128): #Width of the Image
        fh1.write("\n")
        count = 0
    a = fh.readline().rstrip("\n")
fh.close()
fh1.close()