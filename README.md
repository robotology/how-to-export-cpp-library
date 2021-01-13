# 📚 How to export C++ library

This repository provides an OS-agnostic C++ library template with plain [CMake](https://cmake.org/) files with the following features:
  * distribution of the library
  * automatic exposition of symbols for Windows dlls using [`CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS`](https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/)
  * test support with `ctest`
  * [GitHub Actions](https://github.com/features/actions) script configured
  * dedicated [Doxygen](https://www.stack.nl/~dimitri/doxygen/) target for generating documentation

# Overview
- [💢 Complexities around C++ library](#-complexities-around-c++-library)
- [🏅 CI and badges](#️-ci-and-badges)
- [🎛 Dependencies](#-dependencies)
- [🔨 Build the libraries](#-build-the-libraries)
- [✂️ Copy and customize this template](#-copy-and-customize-this-template)
- [🔬 Add a test](#-add-a-test)
- [🐛 Run the tests](#-run-the-tests)
- [📝 Generate documentation](#-generate-documentation)
- [📑 Licensing your library](#-licensing-your-library)
- [💼 Other template and examples](#-other-template-and-examples)

# 💢 Complexities around C++ library
This project simplifies the process of taking a bunch of C++ classes/functions and exposing them as a CMake package so that third-party code can use it. However, the risk is that _new users_ underestimate the actual complexity of maintaining a C++ library used by many external users!

A complete and proper training on the art and craft of C++ library maintenance is out of the scope of this project, but we feel that we should at least report some useful link to drive the curiosity and the attention of new users to topics relevant to a proper maintenence of a C++ library.

Problems typically overlooked by new C++ library developers:
 - [The basics of C/C++ compilation pipeline](https://github.com/green7ea/cpp-compilation/blob/master/README.md)
 - [API/ABI backward compatibility](https://abi-laboratory.pro/index.php?view=binary-compatibility)
 - [Dynamic loading](https://amir.rachum.com/blog/2016/09/17/shared-libraries/)
 - [So you want to know even more about shared/dynamic libraries? There you go!](https://www.akkadia.org/drepper/dsohowto.pdf)
 - [Continuous Delivery](https://www.atlassian.com/continuous-delivery)
 - [Good practices using Git branching](https://nvie.com/posts/a-successful-git-branching-model/)
 - [Version handling](https://semver.org/)
 - [How to properly handle RPATH](https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/RPATH-handling)

# 🏅 CI and badges
Awesomness | Github Actions
-----------| ------------
[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/onqtam/awesome-cmake) | [![GitHub Actions status](https://github.com/robotology/how-to-export-cpp-library/workflows/C++%20CI%20Workflow/badge.svg)](https://github.com/robotology/how-to-export-cpp-library/actions) 

[`Go to the top`](#overview)

# 🎛 Dependencies
There are no dependencies for this template.
However, we make use of the following three files from the [YCM](https://github.com/robotology/ycm) project.
 1. [`AddInstallRPATHSupport`](https://github.com/robotology/ycm/blob/master/modules/AddInstallRPATHSupport.cmake)
 2. [`AddUninstallTarget`](https://github.com/robotology/ycm/blob/master/modules/AddUninstallTarget.cmake)
 3. [`InstallBasicPackageFiles`](https://github.com/robotology/ycm/blob/master/modules/InstallBasicPackageFiles.cmake)

These files can be found under `./cmake` subdirectory and they are **_plain CMake code_**.
Check them out, they make your life easier!

If you like the YCM project and it is not a problem to have it as a dependency, updating the template is as simple as follows.
 1. [Install YCM](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-installing.7.html)
 2. Add `find(YCM REQUIRED)` in the main [CMakeLists.txt](https://github.com/robotology/how-to-export-cpp-library/blob/master/CMakeLists.txt), after the `project()` command.
 3. Delete/Empty the `./cmake` folder.

You are now 100% good to go! 🎉

[`Go to the top`](#overview)

# 🔨 Build the libraries
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

[`Go to the top`](#overview)

# ✂️ Copy and customize this template
For customizing the CMake/C++ code, check the [comments in the main CMakeLists.txt](https://github.com/robotology/how-to-export-cpp-library/blob/master/CMakeLists.txt#L3).

To enable **Continuous Integration** (CI) using [Travis](https://travis-ci.org/) (Linux and macOS) and [AppVeyor](https://www.appveyor.com/) (Windows) follow the documentation of these services to create an account and connect them to your repository.

Once you're done with that, you can easily modify the `appveyor.yml` and `travis.yml` to account changes for your project, such as the project name from `how-to-export-cpp-library` (the name of the git repository) and `LibTemplateCMake` (the name of the CMake Project/Package) to the one of your repository/project.

[`Go to the top`](#overview)

# 🔬 Add a test
This snippet from [`test/CMakeLists.txt`](test/CMakeLists.txt) shows the fundamental commands to add a test:
```cmake
add_executable(test_name_exec test_name_exec_source.cpp)
target_link_libraries(test_name_exec lib-template-cmake)
add_test(NAME test_name COMMAND test_name_exec)
```
A _single_ test is just a simple C++ executable with an `int main()` function that returns 0 on success and any value different from 0 upon failure.

For more info on this topic and related CMake commands, check [`add_test`](https://cmake.org/cmake/help/v3.7/command/add_test.html) documentation and references therein.

[`Go to the top`](#overview)

# 🐛 Run the tests
If you want to run tests, compile the library enabling the `BUILD_TESTING` CMake option. Once you do that, test will be compiled along with the library and any other executable in the project.

To list the compiled/available tests, run `ctest -N` in the build directory.
To run the tests, use `ctest` command in the build directory, while to run a single test, us `ctest -R test_name`.
You can add `-VV` to get a full verbose output during tests.

For more info and options with `ctest`, check the [ctest documentation](https://cmake.org/cmake/help/latest/manual/ctest.1.html).

[`Go to the top`](#overview)

# 📝 Generate documentation
If the Doxygen tool is installed on your machine, the Doxygen documentation for the project can
be generated using the `dox` target, see [`doc/CMakeLists.txt`](https://github.com/robotology/how-to-export-cpp-library/blob/master/doc/CMakeLists.txt) for details on the process of documents
generation. Once generated, the doxygen documentation can be browsed at `build/doc/html/index.html`.
If the documentation is generated, it will be installed in `${CMAKE_INSTALL_PREFIX}/share/doc/${PROJECT_NAME}/html/`.
The build and installation directories for the doxygen documentation can be changed using the `DOXYGEN_BUILD_DIR` and `DOXYGEN_INSTALL_DIR`
CMake variables.

If you are interested on how to host your documentation using `gh-pages`, [robotology/how-to-document-modules](https://github.com/robotology/how-to-document-modules) contains a detailed (and maintained) example on how to produce and host `Doxygen` documentation using GitHub `gh-pages`.

[`Go to the top`](#overview)

# 📑 Licensing your library
The project as-is comes with two files:
 1. `LICENSE`
 2. `LICENSE-template`

**The first file**, `LICENSE`, is the one covering this very template. You **have to** modify/delete it.
⚠️ Don't use it straightforwardly as it includes our name, not yours!

**The second file**, `LICENSE-template`, is an [MIT License](https://en.wikipedia.org/wiki/MIT_License) template that you can use adding the _year_ and _copyright holder names_ in the heading. We provide template of the MIT License as it is the one used for this template, but you can choose one of the many available.

Should you not be sure what to do about it (licensing produces severe headhaces) you can use one of the following website to clear your mind:
 - [Choose a license](http://choosealicense.com/)
 - [tl;drLegal](https://tldrlegal.com/)

[`Go to the top`](#overview)

# 💼 Other template and examples
The [Awesome CMake](https://github.com/onqtam/awesome-cmake) repository contains an interesting [list of template and examples](https://github.com/onqtam/awesome-cmake#examples--templates) similar to this one.

[`Go to the top`](#overview)


---
If you feel this CMake project template was useful, consider starring the project!  
We also created the following shield to provide a nice-looking link to this project (feel free to modify its look-and-feel as you please).  
Otherwise, not a big deal! 👍

[![how-to-export-cpp-library](https://img.shields.io/badge/-Project%20Template-brightgreen.svg?style=flat-square&logo=data%3Aimage%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAAEAAAAA9CAYAAAAd1W%2FBAAAABmJLR0QA%2FwD%2FAP%2BgvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4QEFECsmoylg4QAABRdJREFUaN7tmmuIVVUUx%2F%2F7OmpaaGP6oedkGJWNIWoFVqRZGkIPSrAQgqhEqSYxszeFUB%2FCAqcXUaSRZmZP6IFm42QEUWAjqT1EQ0dLHTMfaWajv76sM%2BxO59znuY%2Bcs2CYmXv33mud31577bX3WU5lEEDOueDvfpLGSBolaaiksyUNknRyqNs%2BSR2SfrKf1ZJaJG11zv1rzJoX4ETgYWAtpcuvwCvABQHcJMUlPevAi5KmxTTbKalN0hZJ2yRlvO%2BOlzTYvOScmP5fSrreOber1mZcQF9gU2j2dgDNwLgixmwE7ge%2BC415FDi%2FFt1%2BuWfkRuBqH1CJYw8B3vfG7wR61NLDn%2BoZt6IcHma%2F7%2FX0zEo6HpRi4KWeYWOTNswfz9OzoKpr3ov2s4HNnmHtwMAy6Vvk6VkPjKkWgInA5zm2r0eBulJn3P6%2FEdgZo2c%2F8BDQu9wP3Qg8DRyIMGJPFhCfAjOAUcAgwOXQ08%2BC3hSb8SMF5AyfANcG4Iteip7L9QMejNjeAlkEjLZ1n490Ah023g%2FAZ0AL8DWwAdgO%2FBnT9y%2Fgdm8CllggbI9ouxeYD4wsNtBcBXwcY8hGYGqo7xjKJyuAyZ6uQ%2Fb5fO%2BzEcCbMf23ANNzeZ6AYcA8oxeWbcDcIAGJWKOlANgCfGNesBR4Cpjqz15ocgIAr0Z4bE%2FgDhsvSt71kzJAAm7O4uJvABfnSmhKBNBY4PL8D4CYdqcBc4CDETp%2Fs3g2SDFGNRVoVCkARhQYlwJ5vgD7JgDLInTvzsT0mQd8BFyTTzrrnGstd84hqR5Y5321LJtNHrABks6V1FfSkVCzeuUxQweAl4Ah2WAAd5XDA4AzgOdCfVbmAe4G22GI2SXATnGFyBrg1rikw05vhcpwIGMBrI%2Bt3UnAMxYgw7Lc7I7Sf7oF0ajcYZ%2BdTBuA24oF4O%2FnS4ErI4w4E3irgLF22f5%2FMEe7r4AJ3vG7y8WBO4Fvs0T%2B8SEb7y4VgC%2B%2FW0QdGFLSC5hmsaRYWWNp7ikRoK%2FL4uLrbZZ7xnhqFwBHske3lZKelfSBc%2B5o6G6wQdJIuxMcIKnBu5FykrZL2iVpq6TVzrm2CMMHS5ouaYak8MPtlfS6pGbn3Ibw3WQYgKTm8LaSpOwHFgCXJHAC7A80AW0xupb4SzGf%2BUx6CeSzxmcBmQLT8Yl2VoiSDZbx9SgSbkUB%2BPKeHZwyMSn1YOBJ4HBM9tYMnFfqNVs1AQTSYQ8zDOgN3AOsi2n7jn%2FxkUTIqgUAuWSTbW3lyi67ANSpdmS3pIWSXnbOra2U0loB8IikJ4JXYJWUTI0AaA%2F260q%2F%2F8uom0sKIAWQAkgBpABSACmAFEAKIAWQAkgBpABSACmAFEB3kc5uBSD0wuUySVN8AB3dgEF%2FK7PdLWmVpOCV3dGMpCGSZkr6%2FliabeA44CagVdIeSXMl1XtNV0kaH%2B58VkQ1RiXklgQBjAYWW11hVLXbfVY2k3OgKfZ%2BvuYB2Bvk2THltIetYOOiYl2pAXgM%2BLkWAHh21dkktcaM2WolgD3DgbCUCDoceK3KAC7MUkO8A5gJ1Fci2DQBP1YCAHCSFWD9EtH3b3Pxy6sVdYdaZVZHEgA8Fw%2Fi0BcxfVqAyUCvklw84STjCuDDEgEMBxbGtPsDeAA4odb34D5WZt%2BeJ4AmK6PZHPHdQeBtYOz%2FNTEZCbwQU%2FaSq0x%2BEtCnqi6eMIxJWUrZAxd%2FPHjoY%2FZQYrnFHIvqh2zNj6uGTf8ARTOPo64fR94AAAAASUVORK5CYII%3D)](https://github.com/robotology/how-to-export-cpp-library)
