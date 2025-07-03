cmake_minimum_required(VERSION 3.10)
project(bbcodelib LANGUAGES CXX)

# Set source directory and files
set(SRC_DIR bbcodelib)
set(SOURCES
    ${SRC_DIR}/bbcode_lexer.cpp
    ${SRC_DIR}/bbcode_parser.cpp
    ${SRC_DIR}/bbcode_utils.cpp
)

# Create debug static library
add_library(bbcodelib_static STATIC ${SOURCES})
set_target_properties(bbcodelib_static PROPERTIES
    OUTPUT_NAME "bbcodelib"
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/Debug"
)

# Create release shared library
add_library(bbcodelib_shared SHARED ${SOURCES})
set_target_properties(bbcodelib_shared PROPERTIES
    OUTPUT_NAME "bbcodelib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/Release"
)

# Include directory
target_include_directories(bbcodelib_static PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(bbcodelib_shared PRIVATE ${CMAKE_SOURCE_DIR})

# Set compile options
target_compile_definitions(bbcodelib_static PRIVATE WIN32 _DEBUG _CONSOLE)
target_compile_definitions(bbcodelib_shared PRIVATE WIN32 NDEBUG _CONSOLE)

target_compile_options(bbcodelib_static PRIVATE -g -O0 -Wall)
target_compile_options(bbcodelib_shared PRIVATE -O2 -Wall)

# Set build types if not set
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# === Test executable ===

# note: testsuite/main.cpp expects message.bb in the workdir

# Add test executable
add_executable(bbcodelib_test testsuite/main.cpp)

# Include same headers as library
target_include_directories(bbcodelib_test PRIVATE ${CMAKE_SOURCE_DIR} ${SRC_DIR})

# Link with shared library
target_link_libraries(bbcodelib_test PRIVATE bbcodelib_shared)

# Set output directory
set_target_properties(bbcodelib_test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/testsuite"
)

# Ensure shared lib is built before test
add_dependencies(bbcodelib_test bbcodelib_shared)
