cmake_minimum_required(VERSION 3.18)

project(boot)

set(CMAKE_CXX_STANDARD 17)

add_library(gpio source/libgpiod_imp.cpp)
add_library(pool source/thread_pool.cpp)

add_executable(bool gpio.cpp)

target_link_libraries(boot gpio)
target_link_libraries(boot pool)