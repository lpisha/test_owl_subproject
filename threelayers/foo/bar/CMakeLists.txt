cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

set(CMAKE_CUDA_ARCHITECTURES 86 CACHE STRING "CUDA architecture")

project(bar LANGUAGES CUDA)

add_library(bar STATIC bar.cu)
