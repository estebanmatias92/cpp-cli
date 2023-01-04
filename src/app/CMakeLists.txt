# Get folder name
get_filename_component(PROJECT_NAME ${CMAKE_CURRENT_LIST_DIR} NAME)

# Set Target Name out of Folder's name
project(${PROJECT_NAME})

# Create lib Target
add_library(${PROJECT_NAME} SHARED)

# Link the INCLUDE path of this Target
target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/include/${PROJECT_NAME})

# Link the libraries for this Target
target_link_libraries(${PROJECT_NAME}
    PUBLIC  cppversion
            e92math)

# Get all SOURCE files and link them to this Target
aux_source_directory(${CMAKE_CURRENT_LIST_DIR} SRC_FILES)
target_sources(${PROJECT_NAME} PRIVATE ${SRC_FILES})