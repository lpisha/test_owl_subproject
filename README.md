This repository is intended as a test case for including OWL as a submodule / library in a parent project in Windows, which OWL does not currently support.

There are two use cases covered:
- twolayers_owl: The parent project is a CUDA project which outputs an executable, and links to the OWL static library at build time.
- threelayers_owl: The direct parent project is a CUDA project which outputs a DLL (shared object), and links to the OWL static library at build time. This DLL is used by a further parent project, which is C++ only and therefore cannot involve a device link step.

To prove that this is a limitation with OWL itself (or rather OWL's outdated CMake configuration) rather than with CMake/CUDA, two other projects are provided, which substitute OWL with a very basic CUDA static library. These build and run correctly.

To use this repository:

## 0. Submodule

1. Make sure you have the OWL submodule, either by having cloned the repo recursively or 
2. Make sure the OWL branch which is currently checked out is lpisha/master (i.e. https://github.com/lpisha/owl.git) or that the recent pull requests submitted by Louis have been merged to the main OWL repo.

## 1. Build twolayers

1. `cd twolayers`
2. `mkdir build_windows`
3. Use the CMake for Windows GUI to configure, generate, and open project in Visual Studio 2017 or 2019.
4. Build. This should complete without errors.
5. `./build_windows/Debug/foo.exe` should output something like `bar done!` `bar!` `foo!` `foo done!`.

## 2. Build threelayers

1. `cd ../threelayers`
2. `mkdir build_windows`
3. Use the CMake for Windows GUI to configure, generate, and open project in Visual Studio 2017 or 2019.
4. Build. This should complete without errors.
5. `cd ./build_windows/Debug`
6. `cp ../foo/Debug/foo.dll .`
7. `./test.exe` should output something like `test starting!` `bar done!` `bar!` `foo!` `foo done!` `test finished!`

## 3. (Fail to) build twolayers_owl

