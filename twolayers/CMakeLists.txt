cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

project(foo LANGUAGES CUDA)

add_subdirectory(bar)

set(CMAKE_CUDA_ARCHITECTURES 86)

add_executable(foo foo.cu)
target_link_libraries(foo PRIVATE bar)

#set_target_properties(foo PROPERTIES
#	CUDA_SEPARABLE_COMPILATION ON
#	POSITION_INDEPENDENT_CODE ON 
#)
