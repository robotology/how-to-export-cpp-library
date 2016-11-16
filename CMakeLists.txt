cmake_minimum_required(VERSION 2.8.11)

### Steps for customization
# 1. Change the argument to project(..) with the name of your library/package
#    (it will be the one used for find_package call)
# 2. Change version information
# 3. Add your libraries as subdirectories in src, i.e. see src/LibTemplateCMake
# 4. Add your executables as subdirectories in src, i.e. see src/ExeExample
# 5. Add the test to your library in test, i.e. see test/chest_sum_and_diff and modify test/CMakeLists.txt accordingly.
# 5. Update src/CMakeLists.txt

# This sets the PROJECT_NAME 
# We use this to export all the files such 
# that is then possible to find_package(LibTemplateCMake) 
# in third party projects 
project(LibTemplateCMake CXX)

set(${PROJECT_NAME}_MAJOR_VERSION 0)
set(${PROJECT_NAME}_MINOR_VERSION 0)
set(${PROJECT_NAME}_PATCH_VERSION 1)
set(${PROJECT_NAME}_VERSION ${${PROJECT_NAME}_MAJOR_VERSION}.${${PROJECT_NAME}_MINOR_VERSION}.${${PROJECT_NAME}_PATCH_VERSION})

# To define the CMAKE_INSTALL_LIBDIR, CMAKE_INSTALL_BINDIR macros
include(GNUInstallDirs)

# To build shared libraries in Windows, we set CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS to TRUE
# See https://cmake.org/cmake/help/v3.4/variable/CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS.html
# See https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# We use InstallBasicPackageFiles, AddUninstallTarget and AddInstallRPATHSupport from YCM
find_package(YCM REQUIRED)

# We keep any additional CMake module use in cmake directory
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

## Options
# Setup options
option(BUILD_SHARED_LIBS "Build libraries as shared as opposed to static" ON)

# Testing related commands
option(BUILD_TESTING "Create tests using CMake" OFF)
if(BUILD_TESTING)
    enable_testing()
endif(BUILD_TESTING)

# Support RPATH?
option(ENABLE_RPATH "Enable RPATH for this library" ON)
mark_as_advanced(ENABLE_RPATH)
include(AddInstallRPATHSupport)
add_install_rpath_support(BIN_DIRS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR}"
                          LIB_DIRS "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}"
                          DEPENDS ENABLE_RPATH
                          USE_LINK_PATH)

# Compile and install related commands
add_subdirectory(src)

# Install the files necessary to call find_package(LibTemplateCMake)
# in CMake projects
include(InstallBasicPackageFiles)
install_basic_package_files(${PROJECT_NAME} VARS_PREFIX ${PROJECT_NAME}
                                            VERSION ${${PROJECT_NAME}_VERSION}
                                            COMPATIBILITY AnyNewerVersion
                                            TARGETS_PROPERTY ${PROJECT_NAME}_TARGETS
                                            NO_CHECK_REQUIRED_COMPONENTS_MACRO)
# Add the uninstall target
include(AddUninstallTarget)

if(BUILD_TESTING)
    # Add integration tests (unit tests for each library should be in each sublibrary directory)
    add_subdirectory(test)
endif()
