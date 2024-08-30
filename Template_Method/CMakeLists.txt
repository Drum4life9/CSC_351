cmake_minimum_required(VERSION 3.28.1)
project(Template_Method)

set(CMAKE_CXX_STANDARD 20)

add_executable(Template_Method main.cpp
        FileEditor.cpp
        FileEditor.h)
