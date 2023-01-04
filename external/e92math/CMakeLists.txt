cmake_minimum_required(VERSION "3.18")

# Settings
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Get folder name
get_filename_component(PROJECT_NAME ${CMAKE_CURRENT_LIST_DIR} NAME)

# Set Target Name out of Folder's name
project(${PROJECT_NAME})

# Create lib Target
add_library(${PROJECT_NAME} SHARED)

# Link the INCLUDE path of this Target
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include)

# Add source and include directories
#add_subdirectory(include)
add_subdirectory(src)