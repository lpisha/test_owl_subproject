This repository is intended as a test case for including OWL as a submodule / library in a parent project in Windows, which the main OWL repository does not currently support, but which Louis's OWLModernCMake branch does.

There are two use cases covered:
- twolayers_owl: The parent project is a CUDA project which outputs an executable, and links to the OWL static library at build time.
- threelayers_owl: The direct parent project is a CUDA project which outputs a DLL (shared object), and links to the OWL static library at build time. This DLL is used by a further parent project, which is C++ only and therefore cannot involve a device link step.

To prove that this is a limitation with OWL itself (or rather OWL's outdated CMake configuration) rather than with CMake/CUDA, two other projects are provided, which substitute OWL with a very basic CUDA static library. These build and run correctly.

To use this repository:

## 0. Submodule

1. Make sure you have the OWL submodule, either by having cloned the repo recursively or `git submodule update --init --recursive`
2. Make sure the OWL branch which is currently checked out is lpisha/OWLModernCMake (i.e. https://github.com/lpisha/owl/tree/OWLModernCMake).

## 1. Build twolayers

1. `cd twolayers`
2. `mkdir build_windows`
3. In the CMake for Windows GUI, click `Configure`.
4. Change CMAKE_CUDA_ARCHITECTURES to your GPU architecture (e.g. 52, 61, 75, 86).
5. Click `Configure` again, then `Generate`, then `Open Project` in Visual Studio 2017 or 2019.
6. Build. This should complete without errors.
7. `./build_windows/Debug/foo.exe` should output something like `bar done!` `bar!` `foo!` `foo done!`.

## 2. Build threelayers

1. Follow the steps above through building except with `threelayers`.
2. `cd ./build_windows/Debug`
3. `cp ../foo/Debug/foo.dll .`
4. `./test.exe` should output something like `test starting!` `bar done!` `bar!` `foo!` `foo done!` `test finished!`

## 3. Build twolayers_owl

1. Make sure the checked-out version of OWL is is lpisha/OWLModernCMake.
2. Follow the steps above through building except with `twolayers_owl`.
3. `./build_windows/Debug/foo.exe` should output a bunch of messages from OWL, the string `foo kernel!`, and then hit an assertion at shutdown with an "Abort/Retry/Ignore" dialog box (normal OWL shutdown behavior).
4. If desired, change the OWL version to owl-project/master (or check OWL_USE_DEPRECATED_CMAKE and uncheck OWL_USE_MODERN_CMAKE) and attempt to build. This will not work, as the CUDA files built in this mode are linked to the static C runtime, while the C++ files are linked to the DLL C runtime, so there will always be link conflicts when linking anything to the static library.

## 4. Build threelayers_owl

1. Follow the steps above through building except with `threelayers_owl`.
2. `cd ./build_windows/Debug`
3. `cp ../foo/Debug/foo.dll .`
4. `./test.exe` should output something like `test starting!` (a bunch of OWL debug messages) `foo kernel!` and then an assertion dialog box as above.

