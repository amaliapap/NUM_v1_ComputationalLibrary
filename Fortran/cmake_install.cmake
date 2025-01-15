# Install script for directory: C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files (x86)/NUMmodel")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "C:/TDM-GCC-64/bin/objdump.exe")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_matlab.dll.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/libNUMmodel_matlab.dll.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_matlab.dll")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib" TYPE SHARED_LIBRARY FILES "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/libNUMmodel_matlab.dll")
  if(EXISTS "$ENV{DESTDIR}/C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_matlab.dll" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_matlab.dll")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "C:/TDM-GCC-64/bin/strip.exe" "$ENV{DESTDIR}/C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_matlab.dll")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  include("C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/CMakeFiles/NUMmodel_matlab.dir/install-cxx-module-bmi-noconfig.cmake" OPTIONAL)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_R.dll.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib" TYPE STATIC_LIBRARY OPTIONAL FILES "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/libNUMmodel_R.dll.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_R.dll")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib" TYPE SHARED_LIBRARY FILES "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/libNUMmodel_R.dll")
  if(EXISTS "$ENV{DESTDIR}/C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_R.dll" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_R.dll")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "C:/TDM-GCC-64/bin/strip.exe" "$ENV{DESTDIR}/C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/../lib/libNUMmodel_R.dll")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  include("C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/CMakeFiles/NUMmodel_R.dir/install-cxx-module-bmi-noconfig.cmake" OPTIONAL)
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/NUMmodeltest.exe")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran" TYPE EXECUTABLE FILES "C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/NUMmodeltest.exe")
  if(EXISTS "$ENV{DESTDIR}/C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/NUMmodeltest.exe" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/NUMmodeltest.exe")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "C:/TDM-GCC-64/bin/strip.exe" "$ENV{DESTDIR}/C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/NUMmodeltest.exe")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  include("C:/Users/ampap/OneDrive - Danmarks Tekniske Universitet/Documents/GitHub/NUMmodel/Fortran/CMakeFiles/NUMmodeltest.dir/install-cxx-module-bmi-noconfig.cmake" OPTIONAL)
endif()

