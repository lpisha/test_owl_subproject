cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

set(BUILD_TYPE_INTERNAL Release) # Debug, RelWithDebInfo, Release

set(CMAKE_BUILD_TYPE ${BUILD_TYPE_INTERNAL})
set(CMAKE_CONFIGURATION_TYPES ${CMAKE_BUILD_TYPE} CACHE STRING "" FORCE) # Only allow Visual Studio to generate the correct build type (not default to Debug)

project(foo LANGUAGES C CXX CUDA)

# OptiX && owl
set(ENV{OptiX_INSTALL_DIR} "${CMAKE_CURRENT_SOURCE_DIR}/optix_7_2_0")
set(OWL_BUILD_SAMPLES OFF CACHE BOOL "Disable OWL samples" FORCE)
set(OWL_BUILD_ADVANCED_TESTS OFF CACHE BOOL "Disable OWL advanced tests" FORCE)
set(OWL_USE_TBB OFF CACHE BOOL "Disable Intel TBB in OWL" FORCE)
add_subdirectory(owl)
include_directories("${CMAKE_CURRENT_SOURCE_DIR}/owl/owl/include" "${OWL_INCLUDES}")

set(CMAKE_CUDA_ARCHITECTURES 86)

add_executable(foo foo.cu)
target_link_libraries(foo PRIVATE owl_static)

#set_target_properties(foo PROPERTIES
#	CUDA_SEPARABLE_COMPILATION ON
#	POSITION_INDEPENDENT_CODE ON 
#)
