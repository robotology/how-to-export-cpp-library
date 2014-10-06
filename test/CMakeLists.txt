set(proj_source_path ../src/${CamelCaseName}/)
include_directories(${proj_source_path} ${CMAKE_CURRENT_BINARY_DIR}/${proj_source_path})

add_executable(check_sum_and_diff_test check_sum_and_diff.cpp)

target_link_libraries(check_sum_and_diff_test ${library_target_name})

add_test(NAME test_check_sum_and_diff COMMAND check_sum_and_diff_test)