set(CTEST_PROJECT_NAME "cgns")
set(CTEST_BUILD_NAME "$ENV{SGEN}-cgns")
set(CTEST_SITE "$ENV{COMPUTERNAME}")

set(VER "$ENV{CGNSLIB_VER}")
set(HDF5_VER "$ENV{HDF5_VER}")
set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/src/cgnslib-${VER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/build/cgnslib-${VER}/${CONF_DIR}")

if("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  if("${CONF_DIR}" STREQUAL "debug")
    set(HDF_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libhdf5_debug.so")
    set(SZIP_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libszip_debug.so")
    set(ZLIB_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libz_debug.so")
  else()
    set(HDF_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libhdf5.so")
    set(SZIP_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libszip.so")
    set(ZLIB_LIB "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/lib/libz.so")
  endif()
endif()


set(BUILD_OPTIONS 
-DCMAKE_INSTALL_PREFIX:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-${VER}/${CONF_DIR}
-DCGNS_BUILD_CGNSTOOLS:BOOL=$ENV{BUILD_TOOLS}
###-DCGNS_ENABLE_FORTRAN:BOOL=ON
-DCGNS_ENABLE_HDF5:BOOL=ON
-DCGNS_ENABLE_LFS:BOOL=ON
-DHDF5_DIR:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/cmake/hdf5
-DHDF5_NEED_SZIP:BOOL=ON
-DHDF5_NEED_ZLIB:BOOL=ON
)

if("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  list(APPEND BUILD_OPTIONS "-DCMAKE_C_FLAGS:STRING=-D_LARGEFILE64_SOURCE")
  list(APPEND BUILD_OPTIONS "-DSZIP_LIBRARY:STRING=${SZIP_LIB}")
  list(APPEND BUILD_OPTIONS "-DZLIB_LIBRARY:STRING=${ZLIB_LIB}")
endif()

CTEST_START("Experimental")
CTEST_CONFIGURE(BUILD "${CTEST_BINARY_DIRECTORY}"
                OPTIONS "${BUILD_OPTIONS}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET install)

if ($ENV{BUILD_TOOLS} MATCHES "[Oo][Nn]")
  if (WIN32)
    # add hdf5 path to cgconfig.bat
    file(RENAME
      ${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-${VER}/${CONF_DIR}/bin/cgconfig.bat
      ${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-${VER}/${CONF_DIR}/bin/cgconfig.bat.orig
    )
    file(STRINGS
      ${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-${VER}/${CONF_DIR}/bin/cgconfig.bat.orig
      lines
    )
    foreach(line IN LISTS lines)
      file(APPEND
        ${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-${VER}/${CONF_DIR}/bin/cgconfig.bat
        "${line}\n"
      )
    endforeach()
    file(TO_NATIVE_PATH "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/bin" HDF5PATH)
    file(APPEND
      ${CTEST_SCRIPT_DIRECTORY}/lib/install/cgnslib-${VER}/${CONF_DIR}/bin/cgconfig.bat
      "set PATH=${HDF5PATH};%PATH%\n"
    )
  endif()
endif()
