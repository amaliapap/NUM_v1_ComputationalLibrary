set(CMAKE_Fortran_COMPILER "C:/TDM-GCC-64/bin/gfortran.exe")
set(CMAKE_Fortran_COMPILER_ARG1 "")
set(CMAKE_Fortran_COMPILER_ID "GNU")
set(CMAKE_Fortran_COMPILER_VERSION "10.3.0")
set(CMAKE_Fortran_COMPILER_WRAPPER "")
set(CMAKE_Fortran_PLATFORM_ID "MinGW")
set(CMAKE_Fortran_SIMULATE_ID "")
set(CMAKE_Fortran_COMPILER_FRONTEND_VARIANT "GNU")
set(CMAKE_Fortran_SIMULATE_VERSION "")




set(CMAKE_AR "C:/TDM-GCC-64/bin/ar.exe")
set(CMAKE_Fortran_COMPILER_AR "C:/TDM-GCC-64/bin/gcc-ar.exe")
set(CMAKE_RANLIB "C:/TDM-GCC-64/bin/ranlib.exe")
set(CMAKE_Fortran_COMPILER_RANLIB "C:/TDM-GCC-64/bin/gcc-ranlib.exe")
set(CMAKE_COMPILER_IS_GNUG77 1)
set(CMAKE_Fortran_COMPILER_LOADED 1)
set(CMAKE_Fortran_COMPILER_WORKS TRUE)
set(CMAKE_Fortran_ABI_COMPILED TRUE)

set(CMAKE_Fortran_COMPILER_ENV_VAR "FC")

set(CMAKE_Fortran_COMPILER_SUPPORTS_F90 1)

set(CMAKE_Fortran_COMPILER_ID_RUN 1)
set(CMAKE_Fortran_SOURCE_FILE_EXTENSIONS f;F;fpp;FPP;f77;F77;f90;F90;for;For;FOR;f95;F95)
set(CMAKE_Fortran_IGNORE_EXTENSIONS h;H;o;O;obj;OBJ;def;DEF;rc;RC)
set(CMAKE_Fortran_LINKER_PREFERENCE 20)
if(UNIX)
  set(CMAKE_Fortran_OUTPUT_EXTENSION .o)
else()
  set(CMAKE_Fortran_OUTPUT_EXTENSION .obj)
endif()

# Save compiler ABI information.
set(CMAKE_Fortran_SIZEOF_DATA_PTR "8")
set(CMAKE_Fortran_COMPILER_ABI "")
set(CMAKE_Fortran_LIBRARY_ARCHITECTURE "")

if(CMAKE_Fortran_SIZEOF_DATA_PTR AND NOT CMAKE_SIZEOF_VOID_P)
  set(CMAKE_SIZEOF_VOID_P "${CMAKE_Fortran_SIZEOF_DATA_PTR}")
endif()

if(CMAKE_Fortran_COMPILER_ABI)
  set(CMAKE_INTERNAL_PLATFORM_ABI "${CMAKE_Fortran_COMPILER_ABI}")
endif()

if(CMAKE_Fortran_LIBRARY_ARCHITECTURE)
  set(CMAKE_LIBRARY_ARCHITECTURE "")
endif()





set(CMAKE_Fortran_IMPLICIT_INCLUDE_DIRECTORIES "C:/TDM-GCC-64/lib/gcc/x86_64-w64-mingw32/10.3.0/finclude;C:/TDM-GCC-64/lib/gcc/x86_64-w64-mingw32/10.3.0/include;C:/TDM-GCC-64/include;C:/TDM-GCC-64/lib/gcc/x86_64-w64-mingw32/10.3.0/include-fixed;C:/TDM-GCC-64/x86_64-w64-mingw32/include")
set(CMAKE_Fortran_IMPLICIT_LINK_LIBRARIES "gfortran;mingw32;gcc_s;gcc;pthread;gcc_s;gcc;kernel32;moldname;mingwex;kernel32;quadmath;m;mingw32;gcc_s;gcc;pthread;gcc_s;gcc;kernel32;moldname;mingwex;kernel32;pthread;advapi32;shell32;user32;kernel32;mingw32;gcc_s;gcc;pthread;gcc_s;gcc;kernel32;moldname;mingwex;kernel32")
set(CMAKE_Fortran_IMPLICIT_LINK_DIRECTORIES "C:/TDM-GCC-64/lib/gcc/x86_64-w64-mingw32/10.3.0;C:/TDM-GCC-64/lib/gcc;C:/TDM-GCC-64/x86_64-w64-mingw32/lib;C:/TDM-GCC-64/lib")
set(CMAKE_Fortran_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")
