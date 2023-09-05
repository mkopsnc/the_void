CXX=g++-13.2.0
F90=gfortran-13.2.0
MEX=mex
CXXVER=17
ARCH=$(shell uname -s | tr '[:upper:]' '[:lower:]')

ifeq ($(ARCH),darwin)
  EXT=dylib
else
  EXT=so
endif

all:
ifeq ($(CXXVER),pre17)
	cp constants_pre17.h constants.h
else
	cp constants_17.h constants.h
endif
	
	$(CXX) -c constants.cc
	$(CXX) -c foo.cc
	$(CXX) -c main.cc
	$(F90) -c fort.f90
	$(F90) -c fort_iso.f90
	mkdir -p lib
	$(CXX) -shared -fpic constants.cc -o lib/libConstants.$(EXT)
	$(CXX) -shared -fpic -I${JAVA_HOME}/include -I${JAVA_HOME}/include/$(ARCH) constants_jni.cc -o lib/libConstantsJava.$(EXT)
	$(CXX) -o main main.o foo.o -Llib -lConstants
	$(F90) -o fort fort.o -Llib -lConstants
	$(F90) -o fort_iso fort_iso.o -Llib -lConstants
	$(JAVA_HOME)/bin/javac -h c -d target java/src/constants/Constants.java
	$(JAVA_HOME)/bin/javac -d target -cp target java/src/constants/Main.java
	$(MEX) get_empty_char.cpp
	$(MEX) get_empty_int.cpp
	$(MEX) get_empty_double.cpp

test_java:
	$(JAVA_HOME)/bin/java -Djava.library.path=$(LD_LIBRARY_PATH):./lib -cp target constants.Main

test_cpp:
	./main

test_fortran:
	./fort
	./fort_iso

test_matlab:
	matlab -nodisplay -nosplash -nodesktop -r "run('test.m'); exit;"

clean:
	-rm *.o
	-rm fort main fort_iso
	-rm -rf target
	-rm -rf c
	-rm -rf lib
	-rm -rf constants.h
	-rm *.mexa64
