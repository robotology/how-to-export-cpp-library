#.rst:
# InstallBasicPackageFiles
# ------------------------
#
# A helper module to make your package easier to be found by other
# projects.
#
#
# .. command:: install_basic_package_files
#
# Create and install a basic version of cmake config files for your
# project::
#
#  install_basic_package_files(<Name>
#                              VERSION <version>
#                              COMPATIBILITY <compatibility>
#                              TARGETS_PROPERTY <property_name>
#                              [NO_SET_AND_CHECK_MACRO]
#                              [NO_CHECK_REQUIRED_COMPONENTS_MACRO]
#                              [VARS_PREFIX <prefix>] # (default = "<name>")
#                              [DESTINATION <destination>]
#                              [NAMESPACE <namespace>] # (default = "<name>::")
#                              [EXTRA_PATH_VARS_SUFFIX path1 [path2 ...]]
#                              [UPPERCASE_FILENAMES | LOWERCASE_FILENAMES]
#                             )
#
# Depending on UPPERCASE_FILENAMES and LOWERCASE_FILENAMES, this
# function generates 3 files:
#
#  - ``<Name>ConfigVersion.cmake`` or ``<name>-config-version.cmake``
#  - ``<Name>Config.cmake`` or ``<name>-config.cmake``
#  - ``<Name>Targets.cmake`` or ``<name>-targets.cmake``
#
# If neither UPPERCASE_FILENAMES nor LOWERCASE_FILENAMES is set, a file
# ``<Name>ConfigVersion.cmake.in`` or
# ``<name>-config-version.cmake.in`` is searched, and the convention
# is chosed according to the file found. If no file was found, the
# uppercase convention is used.
#
# Each file is generated twice, one for the build directory and one for
# the installation directory.  The ``DESTINATION`` argument can be
# passed to install the files in a location different from the default
# one (``CMake`` on Windows, ``${CMAKE_INSTALL_LIBDIR}/cmake/${name}``
# on other platforms.
#
#
# The ``<Name>ConfigVersion.cmake`` is generated using
# ``write_basic_package_version_file``.  The ``VERSION``,
# ``COMPATIBILITY``, ``NO_SET_AND_CHECK_MACRO``, and
# ``NO_CHECK_REQUIRED_COMPONENTS_MACRO`` are passed to this function.
# See the documentation for the :module:`CMakePackageConfigHelpers`
# module for further information. The files in the build and install
# directory are exactly the same.
#
#
# The ``<Name>Config.cmake`` is generated using
# ``configure_package_config_file``.  See the documentation for the
# :module:`CMakePackageConfigHelpers` module for further information.
# The module expects to find a ``<Name>Config.cmake.in`` or
# ``<name>-config.cmake.in`` file in the root directory of the project.
# If the file does not exist, a very basic file is created.
#
# A set of variables are checked and passed to
# ``configure_package_config_file`` as ``PATH_VARS``. For each of the
# ``SUFFIX`` considered, if one of the variables::
#
#     <VARS_PREFIX>_(BUILD|INSTALL)_<SUFFIX>
#     (BUILD|INSTALL)_<VARS_PREFIX>_<SUFFIX>
#
# is defined, the ``<VARS_PREFIX>_<SUFFIX>`` variable will be defined
# before configuring the package.  In order to use that variable in the
# config file, you have to add a line::
#
#   set_and_check(<VARS_PREFIX>_<SUFFIX> \"@PACKAGE_<VARS_PREFIX>_<SUFFIX>@\")
#
# if the path must exist or just::
#
#   set(<VARS_PREFIX>_<SUFFIX> \"@PACKAGE_<VARS_PREFIX>_<SUFFIX>@\")
#
# if the path could be missing.
#
# These variable will have different values whether you are using the
# package from the build tree or from the install directory.  Also these
# files will contain only relative paths, meaning that you can move the
# whole installation and the CMake files will still work.
#
# Default ``PATH_VARS`` suffixes are::
#
#   BINDIR          BIN_DIR
#   SBINDIR         SBIN_DIR
#   LIBEXECDIR      LIBEXEC_DIR
#   SYSCONFDIR      SYSCONF_DIR
#   SHAREDSTATEDIR  SHAREDSTATE_DIR
#   LOCALSTATEDIR   LOCALSTATE_DIR
#   LIBDIR          LIB_DIR
#   INCLUDEDIR      INCLUDE_DIR
#   OLDINCLUDEDIR   OLDINCLUDE_DIR
#   DATAROOTDIR     DATAROOT_DIR
#   DATADIR         DATA_DIR
#   INFODIR         INFO_DIR
#   LOCALEDIR       LOCALE_DIR
#   MANDIR          MAN_DIR
#   DOCDIR          DOC_DIR
#
# more suffixes can be added using the ``EXTRA_PATH_VARS_SUFFIX``
# argument.
#
#
# The ``<name>Targets.cmake`` is generated using
# :command:`export(TARGETS)` in the build tree and
# :command:`install(EXPORT)` in the installation directory.
# The targets are exported using the value for the ``NAMESPACE``
# argument as namespace.
# The targets should be listed in a global property, that must be passed
# to the function using the ``TARGETS_PROPERTY`` argument

#=============================================================================
# Copyright 2013 iCub Facility, Istituto Italiano di Tecnologia
#   Authors: Daniele E. Domenichelli <daniele.domenichelli@iit.it>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)


if(COMMAND install_basic_package_files)
    return()
endif()


include(GNUInstallDirs)
include(CMakePackageConfigHelpers)
include(CMakeParseArguments)


function(INSTALL_BASIC_PACKAGE_FILES _Name)

    # TODO check that _Name does not contain "-" characters

    set(_options NO_SET_AND_CHECK_MACRO
                 NO_CHECK_REQUIRED_COMPONENTS_MACRO
                 UPPERCASE_FILENAMES
                 LOWERCASE_FILENAMES)
    set(_oneValueArgs VERSION
                      COMPATIBILITY
                      TARGETS_PROPERTY
                      VARS_PREFIX
                      DESTINATION
                      NAMESPACE)
    set(_multiValueArgs EXTRA_PATH_VARS_SUFFIX)
    cmake_parse_arguments(_IBPF "${_options}" "${_oneValueArgs}" "${_multiValueArgs}" "${ARGN}")

    if(NOT DEFINED _IBPF_VARS_PREFIX)
        set(_IBPF_VARS_PREFIX ${_Name})
    endif()

    if(NOT DEFINED _IBPF_VERSION)
        message(FATAL_ERROR "VERSION argument is required")
    endif()

    if(NOT DEFINED _IBPF_COMPATIBILITY)
        message(FATAL_ERROR "COMPATIBILITY argument is required")
    endif()

    if(NOT DEFINED _IBPF_TARGETS_PROPERTY)
        message(FATAL_ERROR "TARGETS_PROPERTY argument is required")
    endif()

    if(_IBPF_UPPERCASE_FILENAMES AND _IBPF_LOWERCASE_FILENAMES)
        message(FATAL_ERROR "UPPERCASE_FILENAMES and LOWERCASE_FILENAMES arguments cannot be used together")
    endif()

    # Path for installed cmake files
    if(NOT DEFINED _IBPF_DESTINATION)
        if(WIN32 AND NOT CYGWIN)
            set(_IBPF_DESTINATION CMake)
        else()
            set(_IBPF_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${_Name})
        endif()
    endif()

    if(NOT DEFINED _IBPF_NAMESPACE)
        set(_IBPF_NAMESPACE "${_Name}::")
    endif()

    if(_IBPF_NO_SET_AND_CHECK_MACRO)
        list(APPEND configure_package_config_file_extra_args NO_SET_AND_CHECK_MACRO)
    endif()

    if(_IBPF_NO_CHECK_REQUIRED_COMPONENTS_MACRO)
        list(APPEND configure_package_config_file_extra_args NO_CHECK_REQUIRED_COMPONENTS_MACRO)
    endif()

    string(TOLOWER "${_Name}" _name)
    if(NOT _IBPF_UPPERCASE_FILENAMES AND NOT _IBPF_LOWERCASE_FILENAMES)
        if(EXISTS ${CMAKE_SOURCE_DIR}/${_Name}Config.cmake.in)
            set(_IBPF_UPPERCASE_FILENAMES 1)
        elseif(EXISTS${CMAKE_SOURCE_DIR}/${_name}-config.cmake.in)
            set(_IBPF_LOWERCASE_FILENAMES 1)
        else()
            set(_IBPF_UPPERCASE_FILENAMES 1)
        endif()
    endif()

    if(_IBPF_UPPERCASE_FILENAMES)
        set(_config_filename ${_Name}Config.cmake)
        set(_version_filename ${_Name}ConfigVersion.cmake)
        set(_targets_filename ${_Name}Targets.cmake)
    elseif(_IBPF_LOWERCASE_FILENAMES)
        set(_config_filename ${_name}-config.cmake)
        set(_version_filename ${_name}-config-version.cmake)
        set(_targets_filename ${_name}-targets.cmake)
    endif()

    # Make relative paths absolute (needed later on) and append the
    # defined variables to _(build|install)_path_vars_suffix
    foreach(p BINDIR          BIN_DIR
              SBINDIR         SBIN_DIR
              LIBEXECDIR      LIBEXEC_DIR
              SYSCONFDIR      SYSCONF_DIR
              SHAREDSTATEDIR  SHAREDSTATE_DIR
              LOCALSTATEDIR   LOCALSTATE_DIR
              LIBDIR          LIB_DIR
              INCLUDEDIR      INCLUDE_DIR
              OLDINCLUDEDIR   OLDINCLUDE_DIR
              DATAROOTDIR     DATAROOT_DIR
              DATADIR         DATA_DIR
              INFODIR         INFO_DIR
              LOCALEDIR       LOCALE_DIR
              MANDIR          MAN_DIR
              DOCDIR          DOC_DIR
              ${_IBPF_EXTRA_PATH_VARS_SUFFIX})
        if(DEFINED ${_IBPF_VARS_PREFIX}_BUILD_${p})
            list(APPEND _build_path_vars_suffix ${p})
            list(APPEND _build_path_vars "${_IBPF_VARS_PREFIX}_${p}")
        endif()
        if(DEFINED BUILD_${_IBPF_VARS_PREFIX}_${p})
            list(APPEND _build_path_vars_suffix ${p})
            list(APPEND _build_path_vars "${_IBPF_VARS_PREFIX}_${p}")
        endif()
        if(DEFINED ${_IBPF_VARS_PREFIX}_INSTALL_${p})
            list(APPEND _install_path_vars_suffix ${p})
            list(APPEND _install_path_vars "${_IBPF_VARS_PREFIX}_${p}")
        endif()
        if(DEFINED INSTALL_${_IBPF_VARS_PREFIX}_${p})
            list(APPEND _install_path_vars_suffix ${p})
            list(APPEND _install_path_vars "${_IBPF_VARS_PREFIX}_${p}")
        endif()
    endforeach()



    # Get targets from GLOBAL PROPERTY
    get_property(_targets GLOBAL PROPERTY ${_IBPF_TARGETS_PROPERTY})
    foreach(_target ${_targets})
        list(APPEND ${_IBPF_VARS_PREFIX}_TARGETS ${_Name}::${_target})
    endforeach()
    list(GET ${_IBPF_VARS_PREFIX}_TARGETS 0 _target)



    # <name>ConfigVersion.cmake file (same for build tree and intall)
    write_basic_package_version_file(${CMAKE_BINARY_DIR}/${_version_filename}
                                    VERSION ${_IBPF_VERSION}
                                    COMPATIBILITY ${_IBPF_COMPATIBILITY})
    install(FILES ${CMAKE_BINARY_DIR}/${_version_filename}
            DESTINATION ${_IBPF_DESTINATION})



    # If there is no Config.cmake.in file, write a basic one
    set(_config_cmake_in ${CMAKE_SOURCE_DIR}/${_config_filename}.in)
    if(NOT EXISTS ${_config_cmake_in})
        set(_config_cmake_in ${CMAKE_BINARY_DIR}/${_config_filename}.in)
        file(WRITE ${_config_cmake_in}
"set(${_IBPF_VARS_PREFIX}_VERSION \@${_IBPF_VARS_PREFIX}_VERSION\@)

@PACKAGE_INIT@

set(${_IBPF_VARS_PREFIX}_INCLUDEDIR \"@PACKAGE_${_IBPF_VARS_PREFIX}_INCLUDEDIR@\")

if(NOT TARGET ${_target})
  include(\"\${CMAKE_CURRENT_LIST_DIR}/${_targets_filename}\")
endif()

# Compatibility
set(${_Name}_LIBRARIES ${${_IBPF_VARS_PREFIX}_TARGETS})
set(${_Name}_INCLUDE_DIRS \${${_IBPF_VARS_PREFIX}_INCLUDEDIR})
")
    endif()

    # <name>Config.cmake (build tree)
    foreach(p ${_build_path_vars_suffix})
        if(DEFINED ${_IBPF_VARS_PREFIX}_BUILD_${p})
            set(${_IBPF_VARS_PREFIX}_${p} "${${_IBPF_VARS_PREFIX}_BUILD_${p}}")
        elseif(DEFINED BUILD_${_IBPF_VARS_PREFIX}_${p})
            set(${_IBPF_VARS_PREFIX}_${p} "${BUILD_${_IBPF_VARS_PREFIX}_${p}}")
        endif()
    endforeach()
    configure_package_config_file(${_config_cmake_in}
                                  ${CMAKE_BINARY_DIR}/${_config_filename}
                                  INSTALL_DESTINATION ${CMAKE_BINARY_DIR}
                                  PATH_VARS ${_build_path_vars}
                                  ${configure_package_config_file_extra_args}
                                  INSTALL_PREFIX ${CMAKE_BINARY_DIR})

    # <name>Config.cmake (installed)
    foreach(p ${_install_path_vars_suffix})
        if(DEFINED ${_IBPF_VARS_PREFIX}_INSTALL_${p})
            set(${_IBPF_VARS_PREFIX}_${p} "${${_IBPF_VARS_PREFIX}_INSTALL_${p}}")
        elseif(DEFINED INSTALL_${_IBPF_VARS_PREFIX}_${p})
            set(${_IBPF_VARS_PREFIX}_${p} "${INSTALL_${_IBPF_VARS_PREFIX}_${p}}")
        endif()
    endforeach()
    configure_package_config_file(${_config_cmake_in}
                                  ${CMAKE_BINARY_DIR}/${_config_filename}.install
                                  INSTALL_DESTINATION ${_IBPF_DESTINATION}
                                  PATH_VARS ${_install_path_vars}
                                  ${configure_package_config_file_extra_args})
    install(FILES ${CMAKE_BINARY_DIR}/${_config_filename}.install
            DESTINATION ${_IBPF_DESTINATION}
            RENAME ${_config_filename})



    # <name>Targets.cmake (build tree)
    export(TARGETS ${_targets}
           NAMESPACE ${_IBPF_NAMESPACE}
           FILE ${CMAKE_BINARY_DIR}/${_targets_filename})

    # <name>Targets.cmake (installed)
    install(EXPORT ${_Name}
            NAMESPACE ${_IBPF_NAMESPACE}
            DESTINATION ${_IBPF_DESTINATION}
            FILE ${_targets_filename})

endfunction()
