# This is the "physical" name of the sublibrary built in this directory
set(library_target_name lib-template-cmake)

set(${library_target_name}_SRCS
        src/LibTemplateCMake.cpp
)

set(${library_target_name}_HDRS
        include/LibTemplateCMake/LibTemplateCMake.h
)

add_library(${library_target_name} ${${library_target_name}_SRCS} ${${library_target_name}_HDRS})

set_target_properties(${library_target_name} PROPERTIES VERSION ${${PROJECT_NAME}_VERSION}
                                             PUBLIC_HEADER "${${library_target_name}_HDRS}")

target_include_directories(${library_target_name} PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
                                                         "$<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}>")

install(TARGETS ${library_target_name}
        EXPORT ${PROJECT_NAME}
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT shlib
        ARCHIVE DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT lib
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT bin
        PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/LibTemplateCMake" COMPONENT dev)

set_property(GLOBAL APPEND PROPERTY ${PROJECT_NAME}_TARGETS ${library_target_name})
