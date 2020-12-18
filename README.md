## iricdev-2019 [![Build status](https://ci.appveyor.com/api/projects/status/3ua1m85c1f88nbx1?svg=true)](https://ci.appveyor.com/project/i-RIC/iricdev-2019)

Build libraries needed to build iRIC on Windows

## Windows Visual Studio Community 2019 Build (Full)
* Visual Studio 2019 available from https://visualstudio.microsoft.com/vs/
  Install at least Workload 'Desktop development with C++' (7.02 GB)
  Set environmental variable CL to /MP to speed up compilations
* Qt Visual Studio Tools available from https://marketplace.visualstudio.com/items?itemName=TheQtCompany.QtVisualStudioTools2019
* git available from https://git-scm.com/download/win
* Qt 5.14.2 available from https://www.qt.io/download-qt-installer?hsCtaTracking=99d9dd4f-5681-48d2-b096-470725510d34%7C074ddad0-fdef-4e53-8aa8-5e8a876d6ab4
  Select 'Qt Debug Information Files' and 'Sources' if you want to debug Qt
* 7-zip available from http://www.7-zip.org/
* Add 7-zip installation path to "Path" environment variable.
* NSIS available from http://nsis.sourceforge.net/Download/ (for HDF5 packaging)
* Perl available from https://www.activestate.com/activeperl/downloads (for OpenSSL)
* Tcl available from https://www.activestate.com/activetcl/downloads (sqlite3 required by proj)
* curl available from https://www.nuget.org/packages/curl/ (not required if using the git packaged version or if using Windows 10 >= 17063)
* Python 3 available from https://www.python.org/downloads/

### in a git bash shell
```
git clone https://github.com/i-RIC/iricdev-2019.git
cd iricdev-2019
```
copy programs_std.prop to programs.prop and make any necessary changes (ie path to git curl program)

### in a Command Prompt
```
cd iricdev-2019
msbuild_2019.cmd (or msbuild_2019_w_tools.cmd to build cgns and hdf5 tools)
copy paths.pri [prepost-gui-root]\.
copy dirExt.prop [prepost-gui-root]\tools\data\.
mkdir [prepost-gui-root]\libdlls\debug.
mkdir [prepost-gui-root]\libdlls\release.
:: if building tools
add install\cgnslib-[CGNS_VER]\release\bin and install\hdf5-[HDF5_VER]\release\bin to "Path"
```

or if you want to use the VTK_DEBUG_LEAKS configuration

```
cd iricdev-2019
msbuild_2019.cmd (or msbuild_2019_w_tools.cmd to build cgns and hdf5 tools)
copy paths-debug-vtk-leaks.pri [prepost-gui-root]\paths.pri
copy dirExt-debug-vtk-leaks.prop [prepost-gui-root]\tools\data\dirExt.prop
mkdir [prepost-gui-root]\libdlls\debug.
mkdir [prepost-gui-root]\libdlls\release.
:: if building tools
add install\cgnslib-[CGNS_VER]\release\bin and install\hdf5-[HDF5_VER]\release\bin to "Path"
```
