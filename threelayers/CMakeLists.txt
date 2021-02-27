cmake_minimum_required(VERSION 3.18 FATAL_ERROR)
project(test LANGUAGES CXX)

add_subdirectory(foo)

add_executable(test test.cpp)
target_link_libraries(test PRIVATE foo)
