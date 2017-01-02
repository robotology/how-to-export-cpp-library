LibTemplateCMake [![Build Status](https://travis-ci.org/robotology-playground/lib-template-cmake.svg?branch=master)](https://travis-ci.org/robotology-playground/lib-template-cmake) [![Build status](https://ci.appveyor.com/api/projects/status/64u9i4j4jjcmjdpt/branch/master)](https://ci.appveyor.com/project/traversaro/lib-template-cmake/branch/master)
===========

This repository provides a OS-agnostic C++ library template with [CMake](https://cmake.org/) + [YCM](https://github.com/robotology/ycm) configuration files with the following features:
  * distribution of the library
  * automatic exposition of symbols for Windows dlls using [`CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS`](https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/),
  * test support with `ctest`
  * [Travis](https://travis-ci.org/) + [AppVeyor](https://www.appveyor.com/) script configured

## Dependencies
This template currently depends only on [YCM](https://github.com/robotology/ycm), a set of useful CMake modules.

Installing YCM is easy and straightforward. The official installation guide can be found [here](http://robotology.github.io/ycm/gh-pages/master/manual/ycm-installing.7.html)

## Remove YCM dependency
If you want to remove the YCM dependency so that your project can be compiled with just plain `CMake`, we got you covered.
Just switch to the `NoYCM` branch!

### 📝 **Trivia**
To remove YCM dependency, you just need to copy the following files
 1. [`AddInstallRPATHSupport`](https://github.com/robotology/ycm/blob/master/modules/AddInstallRPATHSupport.cmake)
 2. [`AddUninstallTarget`](https://github.com/robotology/ycm/blob/master/modules/AddUninstallTarget.cmake)
 3. [`InstallBasicPackageFiles`](https://github.com/robotology/ycm/blob/master/modules/InstallBasicPackageFiles.cmake)

from [YCM](https://github.com/robotology/ycm) to the `./cmake` subdirectory of the project folder and remove the `find_package(YCM REQUIRED)` line from the main `CMakeLists.txt`.

## How-To

### Copy and customize this template
For customizing the CMake/C++ code, check the [comments in the main CMakeLists.txt](https://github.com/robotology-playground/lib-template-cmake/blob/master/CMakeLists.txt#L3).

To enable **Continuous Integration** (CI) using [Travis](https://travis-ci.org/) (Linux and macOS) and [AppVeyor](https://www.appveyor.com/) (Windows) follow the documentation of these services to create an account and connect them to your repository.

Once you're done with that, you can easily modify the `appveyor.yml` and `travis.yml` to account changes for your project, such as the project name from `lib-template-cmake` (the name of the git repository) and `LibTemplateCMake` (the name of the CMake Project/Package) to the one of your repository/project.

### Build the library
If your shell environment supports `mkdir`, you can just execute the following commands:

```shell
git clone https://github.com/robotology-playground/lib-template-cmake/
cd lib-template-cmake
cmake ..
cmake --build .
```

You can also create platform specific input files for a native build system using [CMake Generator](https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html).

For more detailed example, check the [CGold section on Generate native tool files](https://cgold.readthedocs.io/en/latest/first-step/generate-native-tool.html).

### Add a test
This snippet from [`test/CMakeLists.txt`](test/CMakeLists.txt) shows the fundamental commands to add a test:
```cmake
add_executable(test_name_exec test_name_exec_source.cpp)
target_link_libraries(test_name_exec lib-template-cmake)
add_test(NAME test_name COMMAND test_name_exec)
```
A _single_ test is just a simple C++ executable with an `int main()` function that returns 0 on success and any value different from 0 upon failure.

For more info on this topic and related CMake commands, check [`add_test`](https://cmake.org/cmake/help/v3.7/command/add_test.html) documentation and references therein.

### Run the tests
If you want to run tests, compile the library enabling the `BUILD_TESTING` CMake option. Once you do that, test will be compiled along with the library and any other executable in the project.

To list the compiled/available tests, run `ctest -N` in the build directory.
To run the tests, use `ctest` command in the build directory, while to run a single test, us `ctest -R test_name`.
You can add `-VV` to get a full verbose output during tests.

For more info and options with `ctest`, check the [ctest documentation](https://cmake.org/cmake/help/latest/manual/ctest.1.html).

## Other template and examples
The [Awesome CMake](https://github.com/onqtam/awesome-cmake) repository contains an interesting [list of template and examples](https://github.com/onqtam/awesome-cmake#tutorials--examples--templates) similar to this one.

The [robotology/how-to-document-modules](https://github.com/robotology/how-to-document-modules) contains a detailed (and maintained) example on how to produce and host `Doxygen` documentation using GitHub `gh-pages`.
