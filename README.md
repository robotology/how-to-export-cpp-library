How to export cpp library
===========

This repository provides an OS-agnostic C++ library template with plain [CMake](https://cmake.org/) files with the following features:
  * distribution of the library
  * automatic exposition of symbols for Windows dlls using [`CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS`](https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/)
  * test support with `ctest`
  * [Travis](https://travis-ci.org/) + [AppVeyor](https://www.appveyor.com/) script configured
  * dedicated [Doxygen](https://www.stack.nl/~dimitri/doxygen/) target for generating documentation

[![Build Status](https://travis-ci.org/robotology/how-to-export-cpp-library.svg?branch=master)](https://travis-ci.org/robotology/how-to-export-cpp-library) [![Build status](https://ci.appveyor.com/api/projects/status/ak6hx3kp0puo4s0y/branch/master?svg=true)](https://ci.appveyor.com/project/robotology/how-to-export-cpp-library/branch/master) [![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/onqtam/awesome-cmake)

## Dependencies
There are no dependencies for this template.
However, we make use of the following three files from the [YCM](https://github.com/robotology/ycm) project.
 1. [`AddInstallRPATHSupport`](https://github.com/robotology/ycm/blob/master/modules/AddInstallRPATHSupport.cmake)
 2. [`AddUninstallTarget`](https://github.com/robotology/ycm/blob/master/modules/AddUninstallTarget.cmake)
 3. [`InstallBasicPackageFiles`](https://github.com/robotology/ycm/blob/master/modules/InstallBasicPackageFiles.cmake)

These files can be found under `./cmake` subdirectory and they are **_plain CMake code_**.
Check them out, they make your life easyer!

If you like the YCM project and it is not a problem to have it as a dependency, updating the template is as simple as follows.
 1. [Install YCM](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-installing.7.html)
 2. Add `find(YCM REQUIRED)` in the main [CMakeLists.txt](https://github.com/robotology/how-to-export-cpp-library/blob/master/CMakeLists.txt), after the `project()` command.
 3. Delete/Empty the `./cmake` folder.

You are now 100% good to go! 🎉

## How-To

### Build the library
If your shell environment supports `mkdir`, you can just execute the following commands:

```shell
git clone https://github.com/robotology/how-to-export-cpp-library.git
cd how-to-export-cpp-library
mkdir build && cd build
cmake ..
cmake --build .
```

You can also create platform specific input files for a native build system using [CMake Generator](https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html).

For more detailed example, check the [CGold section on Generate native tool files](https://cgold.readthedocs.io/en/latest/first-step/generate-native-tool.html).

### Copy and customize this template
For customizing the CMake/C++ code, check the [comments in the main CMakeLists.txt](https://github.com/robotology/how-to-export-cpp-library/blob/master/CMakeLists.txt#L3).

To enable **Continuous Integration** (CI) using [Travis](https://travis-ci.org/) (Linux and macOS) and [AppVeyor](https://www.appveyor.com/) (Windows) follow the documentation of these services to create an account and connect them to your repository.

Once you're done with that, you can easily modify the `appveyor.yml` and `travis.yml` to account changes for your project, such as the project name from `how-to-export-cpp-library` (the name of the git repository) and `LibTemplateCMake` (the name of the CMake Project/Package) to the one of your repository/project.

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

### Generate documentation
If the Doxygen tool is installed on your machine, the Doxygen documentation for the project can
be generated using the `dox` target, see [`doc/CMakeLists.txt`](https://github.com/robotology/how-to-export-cpp-library/blob/master/doc/CMakeLists.txt) for details on the process of documents
generation. Once generated, the doxygen documentation can be browsed at `build/doc/html/index.html`.
If the documentation is generated, it will be installed in `${CMAKE_INSTALL_PREFIX}/share/doc/${PROJECT_NAME}/html/`.
The build and installation directories for the doxygen documentation can be changed using the `DOXYGEN_BUILD_DIR` and `DOXYGEN_INSTALL_DIR`
CMake variables.

If you are interested on how to host your documentation using `gh-pages`, [robotology/how-to-document-modules](https://github.com/robotology/how-to-document-modules) contains a detailed (and maintained) example on how to produce and host `Doxygen` documentation using GitHub `gh-pages`.

### License your library
The project as-is comes with two files:
 1. `LICENSE`
 2. `LICENSE-template`

**The first file**, `LICENSE`, is the one covering this very template. You **have to** modify/delete it.
⚠️ Don't use it straightforwardly as it includes our name, not yours!

**The second file**, `LICENSE-template`, is an [MIT License](https://en.wikipedia.org/wiki/MIT_License) template that you can use adding the _year_ and _copyright holder names_ in the heading. We provide template of the MIT License as it is the one used for this template, but you can choose one of the many available.

Should you not be sure what to do about it (licensing produces severe headhaces) you can use one of the following website to clear your mind:
 - [Choose a license](http://choosealicense.com/)
 - [tl;drLegal](https://tldrlegal.com/)

## Other template and examples
The [Awesome CMake](https://github.com/onqtam/awesome-cmake) repository contains an interesting [list of template and examples](https://github.com/onqtam/awesome-cmake#examples--templates) similar to this one.
