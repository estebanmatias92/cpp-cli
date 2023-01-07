# My custom function to list all subdirs with a CMakeList.txt file in it
get_subdirectories(modules ${CMAKE_CURRENT_LIST_DIR})

# Creating executable Target
add_executable(${PROJECT_NAME} main.cpp)

# Add every subdirectory that has a CMakeLists.txt file
add_subdirectories(${CMAKE_CURRENT_LIST_DIR})

# Link the libraries to this Target
target_link_libraries(${PROJECT_NAME}
        PUBLIC ${modules})
