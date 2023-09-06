CXX=g++
F90=gfortran
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
	cp include/constants_pre17.h include/constants.h
else
	cp include/constants_17.h include/constants.h
endif
	mkdir -p lib
	mkdir -p obj
	mkdir -p bin
	$(CXX) -Iinclude -c cpp/constants.cc -o obj/constants.o
	$(CXX) -Iinclude -c cpp/foo.cc -o obj/foo.o
	$(CXX) -Iinclude -c cpp/main.cc -o obj/main.o
	$(F90) -c fortran/fort.f90 -o obj/fort.o
	$(F90) -c fortran/fort_iso.f90 -o obj/fort_iso.o
	$(CXX) -shared -fpic -Iinclude cpp/constants.cc -o lib/libConstants.$(EXT)
	$(CXX) -shared -fpic -Iinclude -I${JAVA_HOME}/include -I${JAVA_HOME}/include/$(ARCH) cpp/constants_jni.cc -o lib/libConstantsJava.$(EXT)
	$(CXX) -o bin/main obj/main.o obj/foo.o -Llib -lConstants
	$(F90) -o bin/fort obj/fort.o -Llib -lConstants
	$(F90) -o bin/fort_iso obj/fort_iso.o -Llib -lConstants
	$(JAVA_HOME)/bin/javac -h c -d target java/src/constants/Constants.java
	$(JAVA_HOME)/bin/javac -d target -cp target java/src/constants/Main.java
	$(MEX) -Iinclude matlab/get_empty_char.cpp -outdir bin
	$(MEX) -Iinclude matlab/get_empty_int.cpp -outdir bin
	$(MEX) -Iinclude matlab/get_empty_double.cpp -outdir bin

test_java:
	$(JAVA_HOME)/bin/java -Djava.library.path=$(LD_LIBRARY_PATH):./lib -cp target constants.Main

test_cpp:
	./bin/main

test_fortran:
	./bin/fort
	./bin/fort_iso

test_matlab:
	matlab -nodisplay -nosplash -nodesktop -r "oldpath = path; path(oldpath,'bin'); run('matlab/test.m'); exit;"

clean:
	-rm *.o
	-rm -rf target
	-rm -rf c
	-rm -rf lib
	-rm -rf obj
	-rm -rf bin
	-rm -rf constants.h

