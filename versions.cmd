@echo off
REM
REM versions.cmd
REM

set BOOST_VER=1.73.0
set CGNSLIB_VER=4.1.1-patch1
set EXPAT_VER=2.2.6
:: set GDAL_VER=3.1.0
set GDAL_VER=3.0.4
set GEOS_VER=3.8.1
set HDF5_VER=1.8.21
set IRICLIB_ADF_VER=0.2
set IRICLIB_VER=0.2.7
set LIBTIFF_VER=4.1.0
set NETCDF_VER=4.7.4
set OPENSSL_VER=1.0.2p
set PROJ_VER=7.0.1
set QWT_VER=6.1.5
set SHAPELIB_VER=1.5.0
set UDUNITS_VER=2.2.26
set VTK_VER=8.2.0
set YAML_CPP_VER=0.6.3

REM
REM replace . with _
REM
set BOOST_UVER=%BOOST_VER:.=_%
set EXPAT_UVER=R_%EXPAT_VER:.=_%
set OPENSSL_UVER=%OPENSSL_VER:.=_%
if NOT defined BUILD_TOOLS  set BUILD_TOOLS="OFF"

:: nmake cannot create environment variables
if NOT defined GENERATOR    set GENERATOR="Visual Studio 16 2019"
if NOT defined SGEN         set SGEN=vs2019-x64
set VERSIONS_CMD_RUN=YES
