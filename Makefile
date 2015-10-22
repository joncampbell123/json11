all: test lib

AR := ar

lib: libjson11.a
	
libjson11.a: libjson11.o
	rm -fv $@
	$(AR) r $@ $<
	
libjson11.o: json11.cpp json11.hpp
	$(CXX) -c -o libjson11.o -std=c++11 -fno-rtti -fno-exceptions json11.cpp

test: json11.cpp json11.hpp test.cpp
	$(CXX) -O -std=c++11 json11.cpp test.cpp -o test -fno-rtti -fno-exceptions

clean:
	if [ -e test ]; then rm test; fi
	rm -fv *.a *.o

.PHONY: clean
