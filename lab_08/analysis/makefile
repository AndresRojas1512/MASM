CC = g++
SRC_32 = float_32.cpp
SRC_64 = double_64.cpp
SRC_80 = long_80.cpp

SRC = long_80.o double_64.o float_32.o measure.o sinus.o main.o


asm : $(SRC_32) $(SRC_64)
	CC -O0 -S  -fverbose-asm -o 32_no_flag.asm $(SRC_32)
	CC -O0 -S  -fverbose-asm -o 32_m.asm $(SRC_32) -m80387
	CC -O0 -S  -fverbose-asm -o 32_mno.asm $(SRC_32) -mno-80387
	CC -O0 -S  -fverbose-asm -o 64_no_flag.asm $(SRC_64)
	CC -O0 -S  -fverbose-asm -o 64_m.asm $(SRC_64) -m80387
	CC -O0 -S  -fverbose-asm -o 64_mno.asm $(SRC_64) -mno-80387
	CC -O0 -S  -fverbose-asm -o 80_no_flag.asm $(SRC_80)
	CC -O0 -S  -fverbose-asm -o 80_m.asm $(SRC_80) -m80387
	CC -O0 -S  -fverbose-asm -o 80_mno.asm $(SRC_80) -mno-80387

%.o : %.c
	gcc -O0 -c $^

no_flag : $(SRC)
	gcc $^ -lstdc++ -o no.exe

m : $(SRC)
	gcc $^ -lstdc++ -o m.exe

mno : $(SRC)
	gcc $^ -lstdc++ -o mno.exe

clean:
	rm -rf *.asm *.o *.exe