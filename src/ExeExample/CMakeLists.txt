add_executable(ExeExample main.cpp)

target_link_libraries(ExeExample lib-template-cmake)

install(TARGETS ExeExample DESTINATION bin)
