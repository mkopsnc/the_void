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
	mkdir -p lib
	mkdir -p obj
	mkdir -p bin
	$(CXX) -c cpp/constants.cc obj/constants.o
	$(CXX) -c cpp/foo.cc obj/foo.o
	$(CXX) -c cpp/main.cc obj/main.o
	$(F90) -c fortran/fort.f90 obj/fort.o
	$(F90) -c fortran/fort_iso.f90 obj/fort_iso.o
	$(CXX) -shared -fpic cpp/constants.cc -o lib/libConstants.$(EXT)
	$(CXX) -shared -fpic -I${JAVA_HOME}/include -I${JAVA_HOME}/include/$(ARCH) cpp/constants_jni.cc -o lib/libConstantsJava.$(EXT)
	$(CXX) -o bin/main obj/main.o obj/foo.o -Llib -lConstants
	$(F90) -o bin/fort obj/fort.o -Llib -lConstants
	$(F90) -o bin/fort_iso obj/fort_iso.o -Llib -lConstants
	$(JAVA_HOME)/bin/javac -h c -d target java/src/constants/Constants.java
	$(JAVA_HOME)/bin/javac -d target -cp target java/src/constants/Main.java
	$(MEX) matlab/get_empty_char.cpp
	$(MEX) matlab/get_empty_int.cpp
	$(MEX) matlab/get_empty_double.cpp

test_java:
	$(JAVA_HOME)/bin/java -Djava.library.path=$(LD_LIBRARY_PATH):./lib -cp target constants.Main

test_cpp:
	./bin/main

test_fortran:
	./bin/fort
	./bin/fort_iso

test_matlab:
	matlab -nodisplay -nosplash -nodesktop -r "run('matlab/test.m'); exit;"

clean:
	-rm *.o
	-rm -rf target
	-rm -rf c
	-rm -rf lib
	-rm -rf obj
	-rm -rf bin
	-rm -rf constants.h
	-rm *.mexa64

