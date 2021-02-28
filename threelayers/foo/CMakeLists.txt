cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

set(CMAKE_CUDA_ARCHITECTURES 86 CACHE STRING "CUDA architecture")

project(foo LANGUAGES CUDA)

add_subdirectory(bar)

add_library(foo SHARED foo.cu)
target_link_libraries(foo PRIVATE bar)
