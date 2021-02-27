cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

project(bar LANGUAGES CUDA)

set(CMAKE_CUDA_ARCHITECTURES 86)

add_library(bar STATIC bar.cu)

#set_target_properties(bar PROPERTIES
#	CUDA_SEPARABLE_COMPILATION ON
#	POSITION_INDEPENDENT_CODE ON 
#)
