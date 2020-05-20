@echo off
setlocal enableextensions
pushd .
call "C:\Qt\5.14.2\msvc2017_64\bin\qtenv2.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x86_amd64
popd
call versions.cmd
set GENERATOR="Visual Studio 15 2017 Win64"
set SGEN=vs2017-x64
msbuild /nologo /target:vtk-build iricdev.proj
endlocal
