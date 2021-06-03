set(CTEST_PROJECT_NAME "iriclib-2019")
set(CTEST_BUILD_NAME "$ENV{SGEN}-iriclib-2019")
set(CTEST_SITE "$ENV{COMPUTERNAME}")

set(HDF5_VER "$ENV{HDF5_VER}")
set(POCO_VER "$ENV{POCO_VER}")

set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/src/iriclib-git")
set(CTEST_BINARY_DIRECTORY "lib/build/iriclib-2019")

# build PREFIX_PATH (Note the escaped semicolon)
set(PREFIX_PATH "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}/cmake/hdf5")
set(PREFIX_PATH "${PREFIX_PATH}\;${CTEST_SCRIPT_DIRECTORY}/lib/install/poco-${POCO_VER}/lib/cmake/Poco")

# override LIBDIR to be consistent w/ hdf5 and cgns
set(BUILD_OPTIONS
"-DCMAKE_INSTALL_PREFIX:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/${CTEST_PROJECT_NAME}-${CTEST_PROJECT_VERSION}"
"-DCMAKE_PREFIX_PATH:PATH=${PREFIX_PATH}"
"-DCMAKE_INSTALL_LIBDIR:PATH=lib"
)

CTEST_START("Experimental")
CTEST_CONFIGURE(BUILD "${CTEST_BINARY_DIRECTORY}"
                OPTIONS "${BUILD_OPTIONS}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
if (WIN32)
  set(hdf5_dir "${CTEST_SCRIPT_DIRECTORY}/lib/install/hdf5-${HDF5_VER}/${CONF_DIR}")
  set(poco_dir "${CTEST_SCRIPT_DIRECTORY}/lib/install/poco-${POCO_VER}")
  set(unit_dir "${CTEST_BINARY_DIRECTORY}/unittests_cgnsfile/${CONF_DIR}")

  if(${CONF_DIR} STREQUAL "debug")
    # unittests_cgnsfile
    file(INSTALL "${hdf5_dir}/bin/hdf5_D.dll" "${hdf5_dir}/bin/szip_D.dll" "${hdf5_dir}/bin/zlib_D.dll"
         DESTINATION ${unit_dir}
     )
    file(COPY "${poco_dir}/bin/PocoFoundationd.dll"
        DESTINATION ${unit_dir}
    )
  else()
    # unittests_cgnsfile
    file(INSTALL "${hdf5_dir}/bin/hdf5.dll" "${hdf5_dir}/bin/szip.dll" "${hdf5_dir}/bin/zlib.dll"
         DESTINATION ${unit_dir}
    )
    file(COPY "${poco_dir}/bin/PocoFoundation.dll"
        DESTINATION ${unit_dir}
    )
  endif()
endif()
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET RUN_TESTS)
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET install)
