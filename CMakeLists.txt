if(WIN32)
    cmake_minimum_required(VERSION 3.4)
else()
    cmake_minimum_required(VERSION 3.1)
endif()

### CUSTOMIZATION STEPS
# 1. Change the argument to project() with the name of your library/package
#    (it will be the one used for find_package() call)
# 2. Change version information
# 3. Add your library source files in the subdirectories
#    - src/"LibName"/include
#    - src/"LibName"/src
# 4. Add your executable source files in the subdirectories
#    - src/"ExecName"
# 5. Update src/CMakeLists.txt
# 6. Add the tests to your library in /test subdirectory and modify
#    test/CMakeLists.txt accordingly.
###

# This sets the PROJECT_NAME, PROJECT_VERSION as well as other variable
# listed here: https://cmake.org/cmake/help/latest/command/project.html.
# We use this name to export all the files such that is then possible to use
# find_package(LibTemplateCMake) in third party projects.
# LANGUAGES specifies which languages your project supports. To have a broad 
# support with external libraries, it is good practice to list both CXX and C. 
# Infact, some legacy Find<package>.cmake files that require the C language to 
# be enabled and thus using only CXX may cause issues. Note that by default when 
# LANGUAGES is not specified CMake enables both CXX and C.
project(LibTemplateCMake
        LANGUAGES CXX C
        VERSION 0.0.0.0)

# Defines the CMAKE_INSTALL_LIBDIR, CMAKE_INSTALL_BINDIR and many other useful macros.
# See https://cmake.org/cmake/help/latest/module/GNUInstallDirs.html
include(GNUInstallDirs)

# Control where libraries and executables are placed during the build.
# With the following settings executables are placed in <the top level of the
# build tree>/bin and libraries/archives in <top level of the build tree>/lib.
# This is particularly useful to run ctests on libraries built on Windows
# machines: tests, which are executables, are placed in the same folders of
# dlls, which are treated as executables as well, so that they can properly
# find the libraries to run. This is a because of missing RPATH on Windows.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}")

# To build shared libraries in Windows, we set CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS to TRUE.
# See https://cmake.org/cmake/help/v3.4/variable/CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS.html
# See https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# Under MSVC, we set CMAKE_DEBUG_POSTFIX to "d" to add a trailing "d" to library
# built in debug mode. In this Windows user can compile, build and install the
# library in both Release and Debug configuration avoiding naming clashes in the
# installation directories.
if(MSVC)
    set(CMAKE_DEBUG_POSTFIX "d")
endif()

# We use
# - InstallBasicPackageFiles
# - AddUninstallTarget
# - AddInstallRPATHSupport
# from YCM. Files are under the cmake subdirectory.
# See https://github.com/robotology/ycm/
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

### Options
# Shared/Dynamic or Static library?
option(BUILD_SHARED_LIBS "Build libraries as shared as opposed to static" ON)

# Build test related commands?
option(BUILD_TESTING "Create tests using CMake" OFF)
if(BUILD_TESTING)
    enable_testing()
endif()

# Support RPATH?
option(ENABLE_RPATH "Enable RPATH for this library" ON)
mark_as_advanced(ENABLE_RPATH)
include(AddInstallRPATHSupport)
add_install_rpath_support(BIN_DIRS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR}"
                          LIB_DIRS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
                          INSTALL_NAME_DIR "${CMAKE_INSTALL_PREFIX}"
                          DEPENDS ENABLE_RPATH
                          USE_LINK_PATH)

# Encourage user to specify a build type (e.g. Release, Debug, etc.), otherwise set it to Release.
if(NOT CMAKE_CONFIGURATION_TYPES)
    if(NOT CMAKE_BUILD_TYPE)
        message(STATUS "Setting build type to 'Release' as none was specified.")
        set_property(CACHE CMAKE_BUILD_TYPE PROPERTY VALUE "Release")
    endif()
endif()

### Compile- and install-related commands.
add_subdirectory(src)

# Create and install CMake configuration files for your project that are
# necessary to for other projects to call find_package(LibTemplateCMake).
#
# Note that it is extremely important to use exactly the project name while
# installing configuration files (you can use PROJECT_NAME variable to avoid
# any possible error). This is required to allow find_package() to properly
# look for the installed library in system path, in particular in Windows when
# the installation is performed in the default path.
#
# install_basic_package_files() comes with many input parameters to customize
# the configuration files. The parameters used in the following call provide
# basic versions of CMake configuration files.
# See install_basic_package_files() documentation found in ./cmake folder.
#
# Note that if your library depends from other libraries, you are probably
# required to used the install_basic_package_files() DEPENDENCIES option.
include(InstallBasicPackageFiles)
install_basic_package_files(${PROJECT_NAME}
                            VERSION ${${PROJECT_NAME}_VERSION}
                            COMPATIBILITY AnyNewerVersion
                            EXPORT ${PROJECT_NAME}
                            VARS_PREFIX ${PROJECT_NAME}
                            NO_CHECK_REQUIRED_COMPONENTS_MACRO)
# Add the uninstall target
include(AddUninstallTarget)

# Add integration tests (unit tests for each library should be in each sublibrary directory).
if(BUILD_TESTING)
    add_subdirectory(test)
endif()

# Add targets related to doxygen documention generation
add_subdirectory(doc)
