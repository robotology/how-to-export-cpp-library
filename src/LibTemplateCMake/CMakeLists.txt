include(GenerateExportHeader)

set(${library_target_name}_SRCS
    template-lib.cpp
)

set(${library_target_name}_HDRS
    template-lib.h
)

set(library_export_header_name ${library_target_name}-export.h)

add_library(${library_target_name} SHARED ${${library_target_name}_SRCS} ${${library_target_name}_HDRS})

generate_export_header(${library_target_name}
                       EXPORT_FILE_NAME ${library_export_header_name}
                       BASE_NAME ${VARS_PREFIX})

set(${library_target_name}_EXPORT_HDRS "${CMAKE_CURRENT_BINARY_DIR}/${library_export_header_name}")
list(APPEND ${library_target_name}_HDRS ${${library_target_name}_EXPORT_HDRS})

set_target_properties(${library_target_name} PROPERTIES VERSION ${${VARS_PREFIX}_VERSION}
                                              SOVERSION ${${VARS_PREFIX}_VERSION}
                                              PUBLIC_HEADER "${${library_target_name}_HDRS}")

target_include_directories(${library_target_name} PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR};${CMAKE_SOURCE_DIR}/src>"
                                                         "$<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/${${VARS_PREFIX}_INSTALL_INCLUDEDIR}>")

install(TARGETS ${library_target_name}
        EXPORT ${CamelCaseName}
        RUNTIME DESTINATION "${${VARS_PREFIX}_INSTALL_BINDIR}" COMPONENT bin
        LIBRARY DESTINATION "${${VARS_PREFIX}_INSTALL_LIBDIR}" COMPONENT shlib
        PUBLIC_HEADER DESTINATION "${${VARS_PREFIX}_INSTALL_INCLUDEDIR}/${CamelCaseName}" COMPONENT dev)

set_property(GLOBAL APPEND PROPERTY ${VARS_PREFIX}_TARGETS ${library_target_name})
