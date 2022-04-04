main:
	make make_obj
	make link

make_obj:
	gcc -c -o fizz_buzz.o src/fizz_buzz.asm 

link:
	ld -e main -o fizz_buzz fizz_buzz.o -macosx_version_min 12.1 -lSystem \
		-L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib

run:
	make run_ name=fizz_buzz

run_:
	./$(name)
