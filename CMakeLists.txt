cmake_minimum_required(VERSION 2.8)

###############################################
## Project Setup
###############################################

set(PROJECT_NAME starter)
project(${PROJECT_NAME})

## Use cmake to handle versioning
set(VERSION 0.1)
configure_file (
    "${PROJECT_SOURCE_DIR}/version.h.in"
    "${PROJECT_BINARY_DIR}/src/version.h"
)
include_directories("${PROJECT_BINARY_DIR}/src")

add_subdirectory(src)
