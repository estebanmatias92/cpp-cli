# Creating executable Target
add_executable(${PROJECT_NAME} main.cpp)

# Add every subdirectory that has a CMakeLists.txt file
add_subdirectories(${CMAKE_CURRENT_LIST_DIR})

# Get all subdirs names
get_subdirectories(LIB_NAMES ${CMAKE_CURRENT_LIST_DIR})
# Link library names to current target
target_link_libraries(${PROJECT_NAME} PUBLIC ${LIB_NAMES})
