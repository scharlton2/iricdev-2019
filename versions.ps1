##
## versions.ps1
##

$env:BOOST_VER="1.73.0"
$env:EXPAT_VER="2.2.6"
$env:GDAL_VER="3.0.4"
$env:GEOS_VER="3.4.3"
$env:HDF5_VER="1.8.21"
#$env:IRICLIB_VER="0.2.7"
$env:LIBPNG_VER="1.6.37"
$env:LIBTIFF_VER="4.1.0"
$env:NETCDF_VER="4.7.4"
$env:OPENSSL_VER="1.0.2p"
$env:POCO_VER="1.9.4"
$env:PROJ_VER="7.0.1"
$env:QWT_VER="6.1.5"
$env:SHAPELIB_VER="1.5.0"
$env:UDUNITS_VER="2.2.26"
$env:VTK_VER="8.2.0"
$env:YAML_CPP_VER="0.6.3"

##
## replace . with _
##
$env:BOOST_UVER=($env:BOOST_VER).Replace(".", "_")
$env:EXPAT_UVER=($env:EXPAT_VER).Replace(".", "_")
$env:OPENSSL_UVER=($env:OPENSSL_VER).Replace(".", "_")

if (-Not (Test-Path env:BUILD_TOOLS)) { $env:BUILD_TOOLS="OFF" }

## nmake cannot create environment variables
if (-Not (Test-Path env:GENERATOR)) { $env:GENERATOR="Visual Studio 16 2019" }
if (-Not (Test-Path env:SGEN))      { $env:SGEN="vs2019-x64" }
$env:VERSIONS_PS1_RUN="YES"
