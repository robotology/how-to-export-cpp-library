LibTemplateCMake [![Build Status](https://travis-ci.org/robotology-playground/lib-template-cmake.svg?branch=master)](https://travis-ci.org/robotology-playground/lib-template-cmake) [![Build status](https://ci.appveyor.com/api/projects/status/64u9i4j4jjcmjdpt/branch/master)](https://ci.appveyor.com/project/traversaro/lib-template-cmake/branch/master)
===========

Example of a C++ library with [CMake](https://cmake.org/)/[YCM](https://github.com/robotology/ycm) configuration files for:
  * distribution of the library,
  * exposing symbols in shared libraries also in Windows using [`CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS`](https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/), 
  * test support (with relative Travis and AppVeyor script configured).
  
## Dependencies 
This template currently depends only on [YCM](https://github.com/robotology/ycm), 
a set of useful CMake modules. You can install following the instructions at [YCM installation guide](http://robotology.github.io/ycm/gh-pages/master/manual/ycm-installing.7.html)
but you probably already have installed `YCM` if you have a [`YCM` superbuild](https://robotology.github.io/ycm/gh-pages/master/manual/ycm-superbuild.7.html) such as `codyco-superbuild`, `robotology-superbuild` or `gazebo-superbuild` on your computer.  

If you want to remove the YCM dependency so that your project can be compiled with just plain `CMake`, just copy the 
following files:
* [`AddInstallRPATHSupport`](https://github.com/robotology/ycm/blob/master/modules/AddInstallRPATHSupport.cmake)
* [`AddUninstallTarget`](https://github.com/robotology/ycm/blob/master/modules/AddUninstallTarget.cmake)
* [`InstallBasicPackageFiles`](https://github.com/robotology/ycm/blob/master/modules/InstallBasicPackageFiles.cmake)

from `YCM` to the `cmake` subdirectory of the project and remove the `find_package(YCM REQUIRED)` line from 
the main `CMakeLists.txt`. 

## How-To

### Copy and customize this template 
For the modification to do at the CMake/C++ level, check the [comments in the main CMakeLists.txt](https://github.com/robotology-playground/lib-template-cmake/blob/master/CMakeLists.txt#L3). 

To enable Continuous Integration (CI) using [Travis](https://travis-ci.org/) (Linux and macOS) and [AppVeyor](https://www.appveyor.com/) (Windows) follow the documentation of this services to create and account and add your repository. Once you did that, modify the `appveyor.yml` and `travis.yml` to change all the instances of `lib-template-cmake` (the name of the git repository) and `LibTemplateCMake` (the name of the CMake Project/Package) with the names of your repository/project.

### Build the library  
If your shell environment supports `mkdir`, you can just execute the following commands:
~~~
git clone https://github.com/robotology-playground/lib-template-cmake/
cd lib-template-cmake
cmake ..
cmake --build .
~~~

For a more detailed example, check the [CGold section on Generate native tool files](https://cgold.readthedocs.io/en/latest/first-step/generate-native-tool.html) . 

### Run the tests 
Compile the library enabling the `BUILD_TESTING` CMake option. 
Once you do that, run the `ctest` command in the build directory. 
Run `ctest -VV` to get a full verbose run of the tests. 

### Add a test 
This snippet from [`test/CMakeLists.txt`](test/CMakeLists.txt) show
the fundamental commands to add a test:
~~~
add_executable(check_sum_and_diff_test check_sum_and_diff.cpp)
target_link_libraries(check_sum_and_diff_test lib-template-cmake)
add_test(NAME test_check_sum_and_diff COMMAND check_sum_and_diff_test)
~~~
A test is just a simple C++ executable (i.e. containing a `int main()` function ),
that returns 0 on success and any value different from 0 on failure. 

For more info on this, check [`add_test`](https://cmake.org/cmake/help/v3.7/command/add_test.html) documentation.

## Other template and examples 
The [Awesome CMake](https://github.com/onqtam/awesome-cmake) repo contains an interesting [list of template and examples](https://github.com/onqtam/awesome-cmake#tutorials--examples--templates) similar to this one.

The [robotology/how-to-document-modules](https://github.com/robotology/how-to-document-modules) contains an example on how to produce and host Doxygen documentation using `gh-pages`.
