# Generated by CMake

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.5)
   message(FATAL_ERROR "CMake >= 2.6.0 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.6)
#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Protect against multiple inclusion, which would fail when already imported targets are added once more.
set(_targetsDefined)
set(_targetsNotDefined)
set(_expectedTargets)
foreach(_expectedTarget Franka::Franka)
  list(APPEND _expectedTargets ${_expectedTarget})
  if(NOT TARGET ${_expectedTarget})
    list(APPEND _targetsNotDefined ${_expectedTarget})
  endif()
  if(TARGET ${_expectedTarget})
    list(APPEND _targetsDefined ${_expectedTarget})
  endif()
endforeach()
if("${_targetsDefined}" STREQUAL "${_expectedTargets}")
  unset(_targetsDefined)
  unset(_targetsNotDefined)
  unset(_expectedTargets)
  set(CMAKE_IMPORT_FILE_VERSION)
  cmake_policy(POP)
  return()
endif()
if(NOT "${_targetsDefined}" STREQUAL "")
  message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_targetsDefined}\nTargets not yet defined: ${_targetsNotDefined}\n")
endif()
unset(_targetsDefined)
unset(_targetsNotDefined)
unset(_expectedTargets)


# Create imported target Franka::Franka
add_library(Franka::Franka SHARED IMPORTED)

set_target_properties(Franka::Franka PROPERTIES
  INTERFACE_COMPILE_FEATURES "cxx_attribute_deprecated;cxx_constexpr;cxx_defaulted_functions;cxx_deleted_functions;cxx_generalized_initializers;cxx_noexcept;cxx_uniform_initialization"
  INTERFACE_INCLUDE_DIRECTORIES "/workspace/libfranka/include"
)

# Import target "Franka::Franka" for configuration "Release"
set_property(TARGET Franka::Franka APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(Franka::Franka PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Poco::Foundation;Poco::Net"
  IMPORTED_LOCATION_RELEASE "/workspace/libfranka/build/libfranka.so.0.9.2"
  IMPORTED_SONAME_RELEASE "libfranka.so.0.9"
  )

# This file does not depend on other imported targets which have
# been exported from the same project but in a separate export set.

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)
