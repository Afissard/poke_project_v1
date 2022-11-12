title C_to_GB_compilation_instruction
rem instruction to compile the main.c locate in src to main.gb locate into bin

C:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -c -o .\bin\main.o .\src\main.c
C:\gbdk\bin\lcc -Wa-l -Wl-m -Wl-j -DUSE_SFR_FOR_REG -o .\bin\main.gb .\bin\main.o

pause