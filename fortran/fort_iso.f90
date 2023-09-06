program main
  use iso_c_binding
  implicit none
  
  interface
    function getEmptyChar() bind(C, name="c_get_empty_char_") result(result_char)
      use iso_c_binding
      character(kind=C_CHAR) :: result_char
    end function
  end interface

  interface
    function getEmptyDouble() bind(C, name="c_get_empty_double_") result(result_double)
      use iso_c_binding
      real(kind=C_DOUBLE) :: result_double
    end function
  end interface

  interface
    function getEmptyInt() bind(C, name="c_get_empty_int_") result(result_int)
      use iso_c_binding
      integer(kind=C_INT) :: result_int
    end function
  end interface



  character(kind=C_CHAR)  :: empty_fortran_char
  real(kind=C_DOUBLE)     :: empty_fortran_double
  integer(kind=C_INT)     :: empty_fortran_int

  empty_fortran_char   = getEmptyChar()
  empty_fortran_double = getEmptyDouble()
  empty_fortran_int    = getEmptyInt() 

  print *, "Double: ", empty_fortran_double
  print *, "Int: ",    empty_fortran_int
  print *, "Char: ",   empty_fortran_char

end program main
