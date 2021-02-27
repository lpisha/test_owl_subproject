This repository is intended as a test case for including OWL as a submodule / library in a parent project in Windows, which OWL does not currently support.

There are two use cases covered:
- twolayers_owl: The parent project is a CUDA project which outputs an executable, and links to the OWL static library at build time.
- threelayers_owl: The direct parent project is a CUDA project which outputs a DLL (shared object), and links to the OWL static library at build time. This DLL is used by a further parent project, which is C++ only and therefore cannot involve a device link step.

To prove that this is a limitation with OWL itself (or rather OWL's outdated CMake configuration) rather than with CMake/CUDA, two other projects are provided, which substitute OWL with a very basic CUDA static library. These build and run correctly.

To use this repository:

## 0. Submodule

1. Make sure you have the OWL submodule, either by having cloned the repo recursively or `git submodule update --init --recursive`
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

## 3. Build twolayers_owl

1. `cd ../threelayers`
2. `mkdir build_windows`
3. In the CMake for Windows GUI, click the `Environment...` button, and set `OptiX_INSTALL_DIR` to the full path to the `optix_7_2_0` folder.
4. Click `Configure`.
5. Change CMAKE_CUDA_ARCHITECTURES to your GPU architecture (e.g. 86) and check the `OWL_BUILD_ADVANCED_TESTS` box.
6. Click `Configure` again, then `Generate`, then `Open Project` in Visual Studio.
7. Build. This should produce 47 errors, mostly: `mismatch detected for 'RuntimeLibrary': value 'MT_StaticRelease' doesn't match value 'MD_DynamicRelease' in foo.obj`. The CUDA files built as part of OWL with the deprecated toolchain are linked to the static version of the C runtime.
8. Change the line `MSVC_RUNTIME_LIBRARY "MultiThreadedDLL"` to `MSVC_RUNTIME_LIBRARY "MultiThreaded"` in `twolayers_owl/CMakeLists.txt` to change the MSVC runtime library used by `foo` to `MT_StaticRelease`.
9. Delete and re-create the CMake configuration.
10. Build. This should produce 39 errors, mostly: `mismatch detected for 'RuntimeLibrary': value 'MD_DynamicRelease' doesn't match value 'MT_StaticRelease' in foo.obj`. The C++ files built as part of OWL with the deprecated toolchain are linked to the dynamic version of the C runtime.
11. A parent library cannot link to OWL as it uses inconsistent versions of the C runtime.
12. 

