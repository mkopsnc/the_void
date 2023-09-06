#ifndef CONSTANTS_H
#define CONSTANTS_H

namespace constants
{
    constexpr double empty_double  { -9.0E40 };
    constexpr int    empty_int     { -999999999 };
    constexpr char   empty_char    { 'x' };
}

double get_empty_double();
int    get_empty_int();
char   get_empty_char();

extern "C" { double c_get_empty_double_(); }
extern "C" { int    c_get_empty_int_();    }
extern "C" { char   c_get_empty_char_();   }

#endif
