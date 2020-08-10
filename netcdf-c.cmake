set(CTEST_PROJECT_NAME "netcdf-c")
set(CTEST_BUILD_NAME "$ENV{SGEN}-netcdf-c")
set(CTEST_SITE "$ENV{COMPUTERNAME}")

set(VER "$ENV{NETCDF_VER}")
set(HDF5_VER "$ENV{HDF5_VER}")
set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/src/netcdf-c-${VER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/build/netcdf-c-${VER}/${CONF_DIR}")

set(HDF5_INCLUDE_DIR "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/include")
if (WIN32)
#   if("${CONF_DIR}" STREQUAL "debug")
#     set(ZLIB_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/zlib_D.lib")
#     set(SZIP_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/szip_D.lib")
#     set(HDF5_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/hdf5_D.lib")
#     set(HDF5_HL_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/hdf5_hl_D.lib")
#   else()
#     set(ZLIB_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/zlib.lib")
#     set(SZIP_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/szip.lib")
#     set(HDF5_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/hdf5.lib")
#     set(HDF5_HL_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/hdf5_hl.lib")
#   endif()
elseif("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  if("${CONF_DIR}" STREQUAL "debug")
    set(ZLIB_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libz_debug.so.1.2")
    set(SZIP_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libszip_debug.so.2.1")
    set(HDF5_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libhdf5_debug.so.1.8.14")
    set(HDF5_HL_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libhdf5_hl_debug.so.1.8.14")
  else()
    set(ZLIB_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libz.so.1.2")
    set(SZIP_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libszip.so.2.1")
    set(HDF5_LIB    "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libhdf5.so.1.8.14")
    set(HDF5_HL_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libhdf5_hl.so.1.8.14")
  endif()
endif()

# Commandline options:
# -DUSE_DAP:BOOL="0" -DNC_MSVC_STACK_SIZE:STRING="40000000" -DENABLE_DAP:BOOL="0" -DENABLE_DAP2:BOOL="0" -DENABLE_DAP_REMOTE_TESTS:BOOL="0" -DHAVE_BASH:FILEPATH="HAVE_BASH-NOTFOUND" -DHDF5_DIR:PATH="C:/Users/charlton/programs/iricdev_2019/lib/install/hdf5-1.8.21/release/cmake/hdf5" -DCURL_DIR:PATH="CURL_DIR-NOTFOUND" -DCMAKE_INSTALL_PREFIX:PATH="C:/Users/charlton/programs/iricdev_2019/netcdf-c-4.7.4/_vc2019/INSTALL" -DNC_DPKG:FILEPATH="NC_DPKG-NOTFOUND" -DENABLE_DAP4:BOOL="0" -DENABLE_MMAP:BOOL="0" 

# Cache file:

# NC_MSVC_STACK_SIZE:STRING=40000000


# USE_DAP:BOOL=0
# ENABLE_DAP:BOOL=0
# ENABLE_DAP2:BOOL=0
# ENABLE_DAP4:BOOL=0

# ENABLE_DAP_REMOTE_TESTS:BOOL=0
# HAVE_BASH:FILEPATH=HAVE_BASH-NOTFOUND
# HDF5_DIR:PATH=C:/Users/charlton/programs/iricdev_2019/lib/install/hdf5-1.8.21/release/cmake/hdf5
# CURL_DIR:PATH=CURL_DIR-NOTFOUND
# CMAKE_INSTALL_PREFIX:PATH=C:/Users/charlton/programs/iricdev_2019/netcdf-c-4.7.4/_vc2019/INSTALL
# NC_DPKG:FILEPATH=NC_DPKG-NOTFOUND
# ENABLE_MMAP:BOOL=0


set(BUILD_OPTIONS 
  -DCMAKE_INSTALL_PREFIX:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/netcdf-c-${VER}/${CONF_DIR}
  -DENABLE_DAP:BOOL=OFF
  -DENABLE_TESTS:BOOL=OFF
##  -DHDF5_LIB:PATH=${HDF5_LIB}
##  -DHDF5_HL_LIB:PATH=${HDF5_HL_LIB}
##  -DHDF5_INCLUDE_DIR:PATH=${HDF5_INCLUDE_DIR}
##  -DZLIB_INCLUDE_DIR:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/include
##  -DZLIB_LIBRARY:PATH=${ZLIB_LIB}
##  -DSZIP_LIBRARY:PATH=${SZIP_LIB}
  -DBUILD_UTILITIES:BOOL=$ENV{BUILD_TOOLS}
  -DBUILD_TESTING:BOOL=OFF
##  -DMSVC12_REDIST_DIR:PATH=C:/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio\ 12.0/VC/redist
##  -DCMAKE_LIBRARY_PATH:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib
  -DHDF5_DIR:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/cmake/hdf5
)

CTEST_START("Experimental")
CTEST_CONFIGURE(BUILD "${CTEST_BINARY_DIRECTORY}"
                OPTIONS "${BUILD_OPTIONS}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET install)
