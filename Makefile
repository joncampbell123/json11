all: test lib json_pretty_print

AR := ar

lib: libjson11.a
	
libjson11.a: libjson11.o
	rm -fv $@
	$(AR) r $@ $<
	
libjson11.o: json11.cpp json11.hpp
	$(CXX) -c -o libjson11.o -std=c++11 -fPIC -fno-rtti -fno-exceptions json11.cpp

test: json11.cpp json11.hpp test.cpp
	$(CXX) -O -std=c++11 json11.cpp test.cpp -o test -fPIC -fno-rtti -fno-exceptions

json_pretty_print: json_pretty_print.cpp
	$(CXX) -O -std=c++11 json11.cpp json_pretty_print.cpp -o json_pretty_print -fPIC -fno-rtti -fno-exceptions

clean:
	rm -fv *.a *.o test json_pretty_print

.PHONY: clean
