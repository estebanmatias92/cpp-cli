# Get all SOURCE files and link them to this Target
aux_source_directory(${CMAKE_CURRENT_LIST_DIR} SRC_FILES)
target_sources(${PROJECT_NAME} PRIVATE ${SRC_FILES})