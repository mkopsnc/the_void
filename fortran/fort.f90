program fort

implicit none

external         :: c_get_empty_int
integer          :: c_get_empty_int

external         :: c_get_empty_double
double precision :: c_get_empty_double

external         :: c_get_empty_char
byte             :: c_get_empty_char

write(*,*) c_get_empty_int()
write(*,*) c_get_empty_double()
write(*,*) char(c_get_empty_char())

end
