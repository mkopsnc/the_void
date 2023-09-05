#include "constants.h"

#include <iostream>

double foo();

int main()
{
    std::cout << "Double: " << constants::empty_double << std::endl;
    std::cout << "Double: " << get_empty_double()      << std::endl;
    std::cout << "Double: " << foo()                   << std::endl;
    std::cout << "Int:    " << c_get_empty_int_()      << std::endl;
    std::cout << "Char:   " << c_get_empty_char_()     << std::endl;
    return 0;
}
