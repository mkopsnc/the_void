<p align="center">
  <img src="https://github.com/mkopsnc/the_void/blob/master/img/enso.png">
</p>

# ThE_VoId

Simple repository illustrating different means of passing emptiness from one place to another.

## How to build the code

```
make

# for C++ < 17
make CXXVER=pre17
```

## How to override compilers

```
make CXX=some_crazy_compiler F90=some_another_crazy_compiler
```

## How to run the code

```
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:`pwd`/lib
make test_cpp
make test_fortran
make test_java
make test_matlab
```

# How to clean up

```
make clean
```
