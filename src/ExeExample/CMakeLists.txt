set(proj_source_path ../LibTemplateCMake/)
include_directories(${proj_source_path} ${CMAKE_CURRENT_BINARY_DIR}/${proj_source_path})

add_executable(ExeExample main.cpp)

target_link_libraries(ExeExample ${library_target_name})
install(TARGETS ExeExample DESTINATION bin)
