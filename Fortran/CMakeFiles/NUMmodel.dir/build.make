# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe" -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel"

# Include any dependencies generated for this target.
include Fortran/CMakeFiles/NUMmodel.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include Fortran/CMakeFiles/NUMmodel.dir/compiler_depend.make

# Include the progress variables for this target.
include Fortran/CMakeFiles/NUMmodel.dir/progress.make

# Include the compile flags for this target's objects.
include Fortran/CMakeFiles/NUMmodel.dir/flags.make

Fortran/CMakeFiles/NUMmodel.dir/read_input.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/read_input.f90.obj: Fortran/read_input.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/read_input.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\read_input.f90" -o CMakeFiles\NUMmodel.dir\read_input.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/read_input.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/read_input.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\read_input.f90" > CMakeFiles\NUMmodel.dir\read_input.f90.i

Fortran/CMakeFiles/NUMmodel.dir/read_input.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/read_input.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\read_input.f90" -o CMakeFiles\NUMmodel.dir\read_input.f90.s

Fortran/CMakeFiles/NUMmodel.dir/globals.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/globals.f90.obj: Fortran/globals.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/globals.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\globals.f90" -o CMakeFiles\NUMmodel.dir\globals.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/globals.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/globals.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\globals.f90" > CMakeFiles\NUMmodel.dir\globals.f90.i

Fortran/CMakeFiles/NUMmodel.dir/globals.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/globals.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\globals.f90" -o CMakeFiles\NUMmodel.dir\globals.f90.s

Fortran/CMakeFiles/NUMmodel.dir/spectrum.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/spectrum.f90.obj: Fortran/spectrum.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_3) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/spectrum.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\spectrum.f90" -o CMakeFiles\NUMmodel.dir\spectrum.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/spectrum.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/spectrum.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\spectrum.f90" > CMakeFiles\NUMmodel.dir\spectrum.f90.i

Fortran/CMakeFiles/NUMmodel.dir/spectrum.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/spectrum.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\spectrum.f90" -o CMakeFiles\NUMmodel.dir\spectrum.f90.s

Fortran/CMakeFiles/NUMmodel.dir/generalists_simple.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/generalists_simple.f90.obj: Fortran/generalists_simple.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_4) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/generalists_simple.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\generalists_simple.f90" -o CMakeFiles\NUMmodel.dir\generalists_simple.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/generalists_simple.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/generalists_simple.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\generalists_simple.f90" > CMakeFiles\NUMmodel.dir\generalists_simple.f90.i

Fortran/CMakeFiles/NUMmodel.dir/generalists_simple.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/generalists_simple.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\generalists_simple.f90" -o CMakeFiles\NUMmodel.dir\generalists_simple.f90.s

Fortran/CMakeFiles/NUMmodel.dir/generalists.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/generalists.f90.obj: Fortran/generalists.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_5) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/generalists.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\generalists.f90" -o CMakeFiles\NUMmodel.dir\generalists.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/generalists.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/generalists.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\generalists.f90" > CMakeFiles\NUMmodel.dir\generalists.f90.i

Fortran/CMakeFiles/NUMmodel.dir/generalists.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/generalists.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\generalists.f90" -o CMakeFiles\NUMmodel.dir\generalists.f90.s

Fortran/CMakeFiles/NUMmodel.dir/diatoms_simple.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/diatoms_simple.f90.obj: Fortran/diatoms_simple.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_6) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/diatoms_simple.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\diatoms_simple.f90" -o CMakeFiles\NUMmodel.dir\diatoms_simple.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/diatoms_simple.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/diatoms_simple.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\diatoms_simple.f90" > CMakeFiles\NUMmodel.dir\diatoms_simple.f90.i

Fortran/CMakeFiles/NUMmodel.dir/diatoms_simple.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/diatoms_simple.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\diatoms_simple.f90" -o CMakeFiles\NUMmodel.dir\diatoms_simple.f90.s

Fortran/CMakeFiles/NUMmodel.dir/diatoms.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/diatoms.f90.obj: Fortran/diatoms.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_7) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/diatoms.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\diatoms.f90" -o CMakeFiles\NUMmodel.dir\diatoms.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/diatoms.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/diatoms.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\diatoms.f90" > CMakeFiles\NUMmodel.dir\diatoms.f90.i

Fortran/CMakeFiles/NUMmodel.dir/diatoms.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/diatoms.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\diatoms.f90" -o CMakeFiles\NUMmodel.dir\diatoms.f90.s

Fortran/CMakeFiles/NUMmodel.dir/copepods.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/copepods.f90.obj: Fortran/copepods.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_8) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/copepods.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\copepods.f90" -o CMakeFiles\NUMmodel.dir\copepods.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/copepods.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/copepods.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\copepods.f90" > CMakeFiles\NUMmodel.dir\copepods.f90.i

Fortran/CMakeFiles/NUMmodel.dir/copepods.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/copepods.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\copepods.f90" -o CMakeFiles\NUMmodel.dir\copepods.f90.s

Fortran/CMakeFiles/NUMmodel.dir/POM.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/POM.f90.obj: Fortran/POM.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_9) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/POM.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\POM.f90" -o CMakeFiles\NUMmodel.dir\POM.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/POM.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/POM.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\POM.f90" > CMakeFiles\NUMmodel.dir\POM.f90.i

Fortran/CMakeFiles/NUMmodel.dir/POM.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/POM.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\POM.f90" -o CMakeFiles\NUMmodel.dir\POM.f90.s

Fortran/CMakeFiles/NUMmodel.dir/NUMmodel.f90.obj: Fortran/CMakeFiles/NUMmodel.dir/flags.make
Fortran/CMakeFiles/NUMmodel.dir/NUMmodel.f90.obj: Fortran/NUMmodel.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_10) "Building Fortran object Fortran/CMakeFiles/NUMmodel.dir/NUMmodel.f90.obj"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\NUMmodel.f90" -o CMakeFiles\NUMmodel.dir\NUMmodel.f90.obj

Fortran/CMakeFiles/NUMmodel.dir/NUMmodel.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing Fortran source to CMakeFiles/NUMmodel.dir/NUMmodel.f90.i"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\NUMmodel.f90" > CMakeFiles\NUMmodel.dir\NUMmodel.f90.i

Fortran/CMakeFiles/NUMmodel.dir/NUMmodel.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling Fortran source to assembly CMakeFiles/NUMmodel.dir/NUMmodel.f90.s"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && C:\TDM-GCC-64\bin\gfortran.exe $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\NUMmodel.f90" -o CMakeFiles\NUMmodel.dir\NUMmodel.f90.s

# Object files for target NUMmodel
NUMmodel_OBJECTS = \
"CMakeFiles/NUMmodel.dir/read_input.f90.obj" \
"CMakeFiles/NUMmodel.dir/globals.f90.obj" \
"CMakeFiles/NUMmodel.dir/spectrum.f90.obj" \
"CMakeFiles/NUMmodel.dir/generalists_simple.f90.obj" \
"CMakeFiles/NUMmodel.dir/generalists.f90.obj" \
"CMakeFiles/NUMmodel.dir/diatoms_simple.f90.obj" \
"CMakeFiles/NUMmodel.dir/diatoms.f90.obj" \
"CMakeFiles/NUMmodel.dir/copepods.f90.obj" \
"CMakeFiles/NUMmodel.dir/POM.f90.obj" \
"CMakeFiles/NUMmodel.dir/NUMmodel.f90.obj"

# External object files for target NUMmodel
NUMmodel_EXTERNAL_OBJECTS =

Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/read_input.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/globals.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/spectrum.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/generalists_simple.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/generalists.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/diatoms_simple.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/diatoms.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/copepods.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/POM.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/NUMmodel.f90.obj
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/build.make
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/objects1.rsp
Fortran/libNUMmodel.dll: Fortran/CMakeFiles/NUMmodel.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir="C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_11) "Linking Fortran shared library libNUMmodel.dll"
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\NUMmodel.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
Fortran/CMakeFiles/NUMmodel.dir/build: Fortran/libNUMmodel.dll
.PHONY : Fortran/CMakeFiles/NUMmodel.dir/build

Fortran/CMakeFiles/NUMmodel.dir/clean:
	cd /d C:\Users\ampap\ONEDRI~1\DOCUME~1\GitHub\NUMmodel\Fortran && $(CMAKE_COMMAND) -P CMakeFiles\NUMmodel.dir\cmake_clean.cmake
.PHONY : Fortran/CMakeFiles/NUMmodel.dir/clean

Fortran/CMakeFiles/NUMmodel.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel" "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran" "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel" "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran" "C:\Users\ampap\OneDrive - Danmarks Tekniske Universitet\Documents\GitHub\NUMmodel\Fortran\CMakeFiles\NUMmodel.dir\DependInfo.cmake" "--color=$(COLOR)"
.PHONY : Fortran/CMakeFiles/NUMmodel.dir/depend

