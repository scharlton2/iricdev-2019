@echo off
setlocal enableextensions
pushd .
REM call "C:\Qt\5.15.0\msvc2019_64\bin\qtenv2.bat"
call "C:\Qt\5.14.2\msvc2017_64\bin\qtenv2.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
popd
call versions.cmd
set GENERATOR="Visual Studio 16 2019"
set SGEN=vs2019-x64

REM msbuild /nologo /target:all iricdev.proj
REM msbuild /nologo /target:hdf5-build iricdev.proj
REM msbuild /nologo /target:cgnslib-build iricdev.proj
REM msbuild /nologo /target:iriclib-build iricdev.proj
REM msbuild /nologo /target:qwt-build iricdev.proj
REM msbuild /nologo /target:netcdf-c-build iricdev.proj
REM msbuild /nologo /target:gdal-build-release iricdev.proj
REM msbuild /nologo /target:proj-src iricdev.proj
REM msbuild /nologo /target:libtiff-build iricdev.proj
REM msbuild /nologo /target:proj-download iricdev.proj
REM msbuild /nologo /target:sqlite-build iricdev.proj
REM msbuild /nologo /target:proj-build iricdev.proj
REM msbuild /nologo /target:gdal-build iricdev.proj
REM msbuild /nologo /target:gdal-build-release iricdev.proj

REM msbuild /nologo /target:shapelib-build iricdev.proj
REM msbuild /nologo /target:vtk-build iricdev.proj
REM msbuild /nologo /target:all iricdev.proj

REM msbuild /nologo /target:qtwebkit-git-clone iricdev.proj
REM msbuild /nologo /target:qtwebkit-build iricdev.proj

REM msbuild /nologo /target:hdf5-build iricdev.proj
REM msbuild /nologo /target:iriclib-build iricdev.proj
REM msbuild /nologo /target:hdf5-build-release iricdev.proj

REM msbuild /nologo /target:cgnslib-test-move iricdev.proj

msbuild /nologo /target:dump iricdev.proj

endlocal
