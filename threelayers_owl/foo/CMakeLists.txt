cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

set(CMAKE_CUDA_ARCHITECTURES 86 CACHE STRING "CUDA architecture")

project(foo LANGUAGES CXX CUDA)

# OptiX && owl
set(ENV{OptiX_INSTALL_DIR} "${CMAKE_CURRENT_SOURCE_DIR}/../../optix_7_2_0")
set(OWL_BUILD_SAMPLES OFF CACHE BOOL "Disable OWL samples" FORCE)
set(OWL_BUILD_ADVANCED_TESTS OFF CACHE BOOL "Disable OWL advanced tests" FORCE)
set(OWL_USE_TBB OFF CACHE BOOL "Disable Intel TBB in OWL" FORCE)
set(OWL_USE_MODERN_CMAKE ON CACHE BOOL "Require modern CMake" FORCE)
add_subdirectory(../../owl owl)
include_directories(${OWL_INCLUDES})

add_library(foo SHARED foo.cu)
target_link_libraries(foo PRIVATE owl_static)
