a.out: main.cpp my_sort.h
	gcc $< -o $@ -lstdc++ -O3

.PHONY: clean test
clean:
	rm -f a.out
test: a.out
	time ./a.out