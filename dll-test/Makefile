All: TestDll Test

TestDll: TestDll.c
	gcc -c TestDll.c
	gcc TestDll.o -o TestDll.dll -shared

Test: Test.c
	gcc -c Test.c
	gcc Test.o TestDll.dll -o Test
	rm Test.o TestDll.o

clean:
	rm Test.o TestDll.o TestDll.dll Test.exe