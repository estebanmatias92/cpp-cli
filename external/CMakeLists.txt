set(interface_name "external")

add_library(${interface_name} INTERFACE)

# Add every subdirectory that has a CMakeLists.txt file
add_subdirectories(${CMAKE_CURRENT_LIST_DIR})

# Link the libraries to this project
get_subdirectories(LIB_NAMES ${CMAKE_CURRENT_LIST_DIR})
target_link_libraries(${interface_name} 
    INTERFACE ${LIB_NAMES})