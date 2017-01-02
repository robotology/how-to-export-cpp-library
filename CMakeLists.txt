cmake_minimum_required(VERSION 3.4)

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
# listed here: https://cmake.org/cmake/help/latest/command/project.html
# We use this name to export all the files such that is then possible to use
# find_package(LibTemplateCMake) in third party projects.
project(LibTemplateCMake
        LANGUAGES CXX
        VERSION 0.0.0.0)

# Defines the CMAKE_INSTALL_LIBDIR, CMAKE_INSTALL_BINDIR and many other useful macros
# See https://cmake.org/cmake/help/latest/module/GNUInstallDirs.html
include(GNUInstallDirs)

# To build shared libraries in Windows, we set CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS to TRUE
# See https://cmake.org/cmake/help/v3.4/variable/CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS.html
# See https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

# We use
# - InstallBasicPackageFiles
# - AddUninstallTarget
# - AddInstallRPATHSupport
# from YCM. See https://github.com/robotology/ycm/
# If you are unable to satisfy or don't want this dependency, downlowad
# the above-mentioned 3 files, place them under in the project "cmake"
# folder and remove the following find_package() call.
find_package(YCM REQUIRED)

# We keep any additional CMake module in a cmake subdirectory
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
                          DEPENDS ENABLE_RPATH
                          USE_LINK_PATH)

### Compile- and install-related commands
add_subdirectory(src)

# Install the files necessary to call find_package(LibTemplateCMake) in CMake projects
include(InstallBasicPackageFiles)
install_basic_package_files(${PROJECT_NAME} VARS_PREFIX ${PROJECT_NAME}
                                            VERSION ${${PROJECT_NAME}_VERSION}
                                            COMPATIBILITY AnyNewerVersion
                                            TARGETS_PROPERTY ${PROJECT_NAME}_TARGETS
                                            NO_CHECK_REQUIRED_COMPONENTS_MACRO)
# Add the uninstall target
include(AddUninstallTarget)

# Add integration tests (unit tests for each library should be in each sublibrary directory)
if(BUILD_TESTING)
    add_subdirectory(test)
endif()
