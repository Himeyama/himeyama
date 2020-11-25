All: TestLib LTest clean
# All: TestDll DTest clean

TestDll: TestDll.c
	gcc -c TestDll.c
	gcc TestDll.o -o TestDll.dll -shared

TestLib: TestDll.c
	gcc -c TestDll.c
	ar rusv libTest.lib TestDll.o

LTest: Test.c
	gcc -c Test.c
	# gcc Test.o TestDll.dll -o Test
	gcc Test.o -o LTest -L. -llibTest

DTest: Test.c
	gcc -c Test.c
	gcc Test.o TestDll.dll -o Test
	
clean:
	rm Test.o TestDll.o -f