#include <string>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <sstream>
#include "json11.hpp"
#include <cassert>
#include <list>
#include <set>
#include <iostream>
#include <fstream>
#include <unordered_map>

using namespace json11;
using std::string;

// Check that Json has the properties we want.
#include <type_traits>
#define CHECK_TRAIT(x) static_assert(std::x::value, #x)
CHECK_TRAIT(is_nothrow_constructible<Json>);
CHECK_TRAIT(is_nothrow_default_constructible<Json>);
CHECK_TRAIT(is_copy_constructible<Json>);
CHECK_TRAIT(is_nothrow_move_constructible<Json>);
CHECK_TRAIT(is_copy_assignable<Json>);
CHECK_TRAIT(is_nothrow_move_assignable<Json>);
CHECK_TRAIT(is_nothrow_destructible<Json>);

int main(int argc, char **argv) {
    string buf,line,err;

    if (argc == 1) {
        fprintf(stderr,"json_pretty_print -             parse JSON from stdin and pretty print\n");
	fprintf(stderr,"json_pretty_print <file>        parse JSON from file and pretty print\n");
	return 1;
    }

    if (argv[1] == string("-")) {
        while (std::getline(std::cin, line))
            buf += line + "\n";
    }
    else {
        std::ifstream infile;

        infile.open(argv[1]);
        if (!infile.is_open()) {
            fprintf(stderr,"Failed to open input file %s\n",argv[1]);
            return 1;
        }
        while (std::getline(infile, line))
            buf += line + "\n";
        infile.close();
    }

    auto json = Json::parse(buf, err);
    if (!err.empty()) {
        fprintf(stderr,"Failed to parse JSON: %s\n", err.c_str());
	return 1;
    } else {
        printf("%s\n", json.dump(Json::pretty_print).c_str());
    }

    return 0;
}

