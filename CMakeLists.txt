cmake_minimum_required(VERSION 2.8.11)

set(CamelCaseName LibTemplateCMake)
set(VARS_PREFIX "LIB_TEMPLATE_CMAKE")
set(library_target_name template-lib)

project(${CamelCaseName} CXX)


set(${VARS_PREFIX}_MAJOR_VERSION 0)
set(${VARS_PREFIX}_MINOR_VERSION 0)
set(${VARS_PREFIX}_PATCH_VERSION 1)
set(${VARS_PREFIX}_VERSION ${${VARS_PREFIX}_MAJOR_VERSION}.${${VARS_PREFIX}_MINOR_VERSION}.${${VARS_PREFIX}_PATCH_VERSION})

find_package(YCM REQUIRED)
include(YCMDefaultDirs)
ycm_default_dirs(${VARS_PREFIX})

#setup options
option(DISABLE_RPATH "Disable support to RPATH" FALSE)
mark_as_advanced(DISABLE_RPATH)

if(NOT DISABLE_RPATH)
    if(${CMAKE_MINIMUM_REQUIRED_VERSION} VERSION_GREATER "2.8.12")
        message(AUTHOR_WARNING "CMAKE_MINIMUM_REQUIRED_VERSION is now ${CMAKE_MINIMUM_REQUIRED_VERSION}. This check can be removed.")
    endif()
    if(CMAKE_VERSION VERSION_LESS 2.8.12)
        set(CMAKE_INSTALL_NAME_DIR "${CMAKE_INSTALL_FULL_LIBDIR}")
        set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_FULL_LIBDIR}")
    else()
        # This is relative RPATH for libraries built in the same project
        # I assume that the directory is
        #  - install_dir/something for binaries
        #  - install_dir/lib for libraries
        # in this way if libraries and executables are moved together everything will continue to work
        file(RELATIVE_PATH _rel_path "${CMAKE_INSTALL_FULL_BINDIR}" "${CMAKE_INSTALL_FULL_LIBDIR}")
        if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
            set(CMAKE_INSTALL_RPATH "@loader_path/${_rel_path}")
        else()
            set(CMAKE_INSTALL_RPATH "\$ORIGIN/${_rel_path}")
        endif()
    endif()
    set(CMAKE_MACOSX_RPATH 1)

    # When building, don't use the install RPATH already
    # (but later on when installing)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)

    # Add the automatically determined parts of the RPATH
    # which point to directories outside the build tree to the install RPATH
    set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
endif(NOT DISABLE_RPATH)

# Compile and install related commands
add_subdirectory(src)

include(InstallBasicPackageFiles)
install_basic_package_files(${CamelCaseName} VARS_PREFIX ${VARS_PREFIX}
                                             VERSION ${${VARS_PREFIX}_VERSION}
                                             COMPATIBILITY SameMajorVersion
                                             TARGETS_PROPERTY ${VARS_PREFIX}_TARGETS
                                             NO_CHECK_REQUIRED_COMPONENTS_MACRO)
                                             
include(AddUninstallTarget)
                  
# Testing related commands 
option(CREATE_TESTS "Create regression tests using CMake" FALSE)
if(CREATE_TESTS)
   enable_testing()
   add_subdirectory(test)
endif(CREATE_TESTS)
