set(CTEST_PROJECT_NAME "zlib")
set(CTEST_PROJECT_VERSION "$ENV{ZLIB_VER}")
set(CTEST_BUILD_NAME "$ENV{SGEN}-zlib")
set(CTEST_SITE "$ENV{COMPUTERNAME}")

set(VER "$ENV{ZLIB_VER}")

set(CTEST_SOURCE_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/src/zlib-${VER}")
set(CTEST_BINARY_DIRECTORY "${CTEST_SCRIPT_DIRECTORY}/lib/build/zlib-${VER}/${CONF_DIR}")

set(BUILD_OPTIONS 
"-DCMAKE_INSTALL_PREFIX:PATH=${CTEST_SCRIPT_DIRECTORY}/lib/install/zlib-${VER}"
)

# Start
ctest_start("Experimental")

# Configure
ctest_configure(BUILD "${CTEST_BINARY_DIRECTORY}"
                OPTIONS "${BUILD_OPTIONS}"
                CAPTURE_CMAKE_ERROR configure_error)
if(configure_error)
  message(FATAL_ERROR "*** Configure failed ***")
endif()

# Build
ctest_build(BUILD "${CTEST_BINARY_DIRECTORY}"
            CAPTURE_CMAKE_ERROR build_error)
if(build_error)
  message(FATAL_ERROR "*** Build failed ***")
endif()

# Test
ctest_test(RETURN_VALUE return_value
           CAPTURE_CMAKE_ERROR test_error)
if(test_error OR return_value)
  message(FATAL_ERROR "*** Test failed ***")
endif()

# Install
ctest_build(BUILD "${CTEST_BINARY_DIRECTORY}"
            TARGET install
            CAPTURE_CMAKE_ERROR install_error)
if(install_error)
  message(FATAL_ERROR "*** Install failed ***")
endif()
