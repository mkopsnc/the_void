#include "jni.h"
#include "constants.h"

extern "C" {

JNIEXPORT double JNICALL Java_constants_Constants_getEmptyDouble
  (JNIEnv * env, jclass obj) {

  return constants::empty_double;

}

JNIEXPORT int JNICALL Java_constants_Constants_getEmptyInt
  (JNIEnv * env, jclass obj) {

  return constants::empty_int;

}

JNIEXPORT char JNICALL Java_constants_Constants_getEmptyChar
  (JNIEnv * env, jclass obj) {

  return constants::empty_char;

}

}

