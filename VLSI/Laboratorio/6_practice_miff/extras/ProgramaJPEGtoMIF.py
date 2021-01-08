#ProgramaJPEGtoMIF
#this program converts image to .mif (black & white)
# Autores MI Elizabeth Fonseca Chávez- MI Mario Alfredo Ibarra Carrillo
#
import sys
from PIL import Image
import numpy


#checking the origin's file format
origin=Image.open("tree.jpg")


#Opening the image file
image=origin.convert('L').resize((20,20),Image.ANTIALIAS)
image=numpy.array(image)
[rows,cols]=image.shape

#Writing the .mif file
f=open("tree.miff","wt")

f.write("DEPTH = "+str (rows*cols) +";\n")
f.write("WIDTH = "+str (8) +";\n")

f.write("ADDRESS_RADIX = UNS;\n")
f.write("DATA_RADIX = UNS;\n")

f.write("CONTENT\n")
f.write("BEGIN\n")

indx=0
for k in image.reshape(rows*cols):
    f.write(str(indx) + " : " + str(k) + ";\n")
    indx+=1

f.write("END;\n")
f.close()

print("Conversion finished")


# In[ ]: