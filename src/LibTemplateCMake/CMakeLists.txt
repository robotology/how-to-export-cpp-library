include(GenerateExportHeader)

set(template_lib_SRCS
    template-lib.cpp
)

set(template_lib_HDRS
    template-lib.h
)

set(library_export_header_name ${library_target_name}-export.h)

add_library(${library_target_name} SHARED ${template_lib_SRCS} ${template_lib_HDRS})

generate_export_header(${library_target_name}
                       EXPORT_FILE_NAME ${library_export_header_name})

set(template_lib_EXPORT_HDRS "${CMAKE_CURRENT_BINARY_DIR}/${library_export_header_name}")
list(APPEND template_lib_HDRS ${template_lib_EXPORT_HDRS})

set_target_properties(${library_target_name} PROPERTIES VERSION ${${VARS_PREFIX}_VERSION}
                                              SOVERSION ${${VARS_PREFIX}_VERSION}
                                              PUBLIC_HEADER "${template_lib_HDRS}")

target_include_directories(${library_target_name} PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR};${CMAKE_SOURCE_DIR}/src>"
                                                         "$<INSTALL_INTERFACE:${${VARS_PREFIX}_INSTALL_INCLUDEDIR}>")

install(TARGETS ${library_target_name}
        EXPORT LibTemplateCMake
        RUNTIME DESTINATION "${${VARS_PREFIX}_INSTALL_BINDIR}" COMPONENT bin
        LIBRARY DESTINATION "${${VARS_PREFIX}_INSTALL_LIBDIR}" COMPONENT shlib
        PUBLIC_HEADER DESTINATION "${${VARS_PREFIX}_INSTALL_INCLUDEDIR}/LibTemplateCMake" COMPONENT dev)

set_property(GLOBAL APPEND PROPERTY ${VARS_PREFIX}_TARGETS ${library_target_name})
