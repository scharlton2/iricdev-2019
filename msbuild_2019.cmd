@echo off
setlocal enableextensions
pushd .
call "C:\Qt\5.14.2\msvc2017_64\bin\qtenv2.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x86_amd64
popd
call versions.cmd
set GENERATOR="Visual Studio 16 2019"
set SGEN=vs2019-x64

REM msbuild /nologo /target:all iricdev.proj HDF5 failure
msbuild /nologo /target:hdf5-build iricdev.proj
endlocal
