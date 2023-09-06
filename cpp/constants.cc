#include "constants.h"

double get_empty_double() {
  return constants::empty_double;
}

int get_empty_int() {
  return constants::empty_int;
}

char get_empty_char() {
  return constants::empty_char;
}

extern "C" {
  double c_get_empty_double_() {
    return get_empty_double();
  }
}

extern "C" {
  int c_get_empty_int_() {
    return get_empty_int();
  }
}

extern "C" {
  char c_get_empty_char_() {
    return get_empty_char();
  }
}

