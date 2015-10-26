all: test lib json_pretty_print

DESTDIR :=
PREFIX := /usr/local
CXX := g++
AR := ar

# LIBDIRNAME should be lib for 32-bit, lib64 for 64-bit
LIBDIRNAME := lib

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

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(PREFIX)/$(LIBDIRNAME)
	mkdir -p $(DESTDIR)$(PREFIX)/include
	cp -v json_pretty_print $(DESTDIR)$(PREFIX)/bin/
	cp -v json11.hpp $(DESTDIR)$(PREFIX)/include/
	cp -v libjson11.a $(DESTDIR)$(PREFIX)/$(LIBDIRNAME)/

clean:
	rm -fv *.a *.o test json_pretty_print

.PHONY: clean
