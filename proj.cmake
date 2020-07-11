set(CTEST_BUILD_NAME "$ENV{SGEN}-proj")
set(CTEST_SITE "$ENV{COMPUTERNAME}")

set(VER "$ENV{PROJ_VER}")
set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/src/proj-${VER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/build/proj-${VER}/${CONF_DIR}")

set(BUILD_OPTIONS 
-DBUILD_PROJSYNC:BOOL=0
-DENABLE_CURL:BOOL=0
-DBUILD_SHARED_LIBS:BOOL=1
-DCMAKE_VERBOSE_MAKEFILE:BOOL=1
-DCMAKE_INSTALL_PREFIX:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/proj-${VER}/${CONF_DIR}
-DTIFF_INCLUDE_DIR:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/tiff-$ENV{LIBTIFF_VER}/${CONF_DIR}/include
-DTIFF_LIBRARY_RELEASE:FILEPATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/tiff-$ENV{LIBTIFF_VER}/release/lib/tiff.lib
-DTIFF_LIBRARY_DEBUG:FILEPATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/tiff-$ENV{LIBTIFF_VER}/debug/lib/tiffd.lib
-DSQLITE3_INCLUDE_DIR:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/sqlite-src-3320300/${CONF_DIR}
-DEXE_SQLITE3:FILEPATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/sqlite-src-3320300/${CONF_DIR}/sqlite3.exe
-DSQLITE3_LIBRARY:FILEPATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/sqlite-src-3320300/${CONF_DIR}/sqlite3.lib
)

CTEST_START("Experimental")
CTEST_CONFIGURE(BUILD "${CTEST_BINARY_DIRECTORY}"
                OPTIONS "${BUILD_OPTIONS}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}")
CTEST_BUILD(BUILD "${CTEST_BINARY_DIRECTORY}" TARGET install)

# For testing
#   cd ${CTEST_BINARY_DIRECTORY}
#   ctest . -C ${CONF_DIR}
if (WIN32)
    # sqlite3
    file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/sqlite-src-3320300/${CONF_DIR}/sqlite3.dll"
         DESTINATION "${CTEST_SCRIPT_DIRECTORY}/lib/build/proj-${VER}/${CONF_DIR}/bin/${CONF_DIR}"
        )
    # tiff
    if(${CONF_DIR} STREQUAL "debug")
        file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/tiff-$ENV{LIBTIFF_VER}/${CONF_DIR}/bin/tiffd.dll"
             DESTINATION "${CTEST_SCRIPT_DIRECTORY}/lib/build/proj-${VER}/${CONF_DIR}/bin/${CONF_DIR}"
            )
    else()
        file(COPY "${CTEST_SCRIPT_DIRECTORY}/lib/install/tiff-$ENV{LIBTIFF_VER}/${CONF_DIR}/bin/tiff.dll"
             DESTINATION "${CTEST_SCRIPT_DIRECTORY}/lib/build/proj-${VER}/${CONF_DIR}/bin/${CONF_DIR}"
            )
    endif()
endif()
# passes 34/35 tests
# Fails Test #11: geotiff_grids (AdobeDeflate compression support)
