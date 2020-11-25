All: TestDll Test clean

TestDll: TestDll.c
	gcc -c TestDll.c
	gcc TestDll.o -o TestDll.dll -shared

Test: Test.c
	gcc -c Test.c
	gcc Test.o TestDll.dll -o Test

clean:
	rm Test.o TestDll.o