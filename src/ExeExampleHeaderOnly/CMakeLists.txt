set(EXE_TARGET_NAME ExeExampleHeaderOnly)

set(${EXE_TARGET_NAME}_SRC
        main.cpp
)

add_executable(${EXE_TARGET_NAME} ${${EXE_TARGET_NAME}_SRC})

target_link_libraries(${EXE_TARGET_NAME} LibTemplateCMake::LibTemplateCMakeHeaderOnly)

install(TARGETS ${EXE_TARGET_NAME} DESTINATION bin)
