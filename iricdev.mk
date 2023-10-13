# ubuntu-22.04
# sudo apt install build-essential
# sudo apt install gfortran
# sudo apt install curl
# sudo apt install p7zip-full
# sudo apt install ninja-build
# sudo apt install swig
# sudo apt install python3-dev

# versions

export HDF5_VER=$(shell awk '/^set HDF5_VER/ {print $2}' versions.cmd | sed 's/[^=]*=//')
export IRICLIB_VER=$(shell awk '/^set IRICLIB_VER/ {print $2}' versions.cmd | sed 's/[^=]*=//')
export POCO_VER=$(shell awk '/^set POCO_VER/ {print $2}' versions.cmd | sed 's/[^=]*=//')
export VTK_VER=$(shell awk '/^set VTK_VER/ {print $2}' versions.cmd | sed 's/[^=]*=//')

export HDF5_MAJMIN=$(shell echo $(HDF5_VER) | sed -e 's/\./ /g' | awk '{ print $$1"."$$2 }')
export VTK_MAJMIN=$(shell echo $(VTK_VER) | sed -e 's/\./ /g' | awk '{ print $$1"."$$2 }')

# programs
CURL := curl -L -O
MKDIR := mkdir -p

# directories
BUILD_DIR := lib/build
DOWNLOADS_DIR := downloads
INSTALL_DIR := lib/install
LOG_DIR := logs
SRC_DIR := lib/src

# cmake
# GENERATOR := Unix Makefiles
# SGEN := make
GENERATOR := Ninja Multi-Config
SGEN := ninja

# environment
export SGEN

DEPS := $(INSTALL_DIR)/hdf5-$(HDF5_VER)/lib/libhdf5.so
DEPS += $(INSTALL_DIR)/hdf5-$(HDF5_VER)/lib/libhdf5_debug.so
DEPS += $(INSTALL_DIR)/poco-$(POCO_VER)/lib/libPocoFoundation.so
DEPS += $(INSTALL_DIR)/poco-$(POCO_VER)/lib/libPocoFoundationd.so
DEPS += $(INSTALL_DIR)/iriclib-$(IRICLIB_VER)/lib/libiriclib.so
DEPS += $(INSTALL_DIR)/iriclib-$(IRICLIB_VER)/lib/libiriclibd.so
# DEPS += $(INSTALL_DIR)/vtk-$(VTK_VER)/debug/lib/libvtkCommonCore-$(VTK_MAJMIN).so
# DEPS += $(INSTALL_DIR)/vtk-$(VTK_VER)/release/lib/libvtkCommonCore-$(VTK_MAJMIN).so

all : $(DEPS)


# iriclib


iriclib-build : $(INSTALL_DIR)/iriclib-$(IRICLIB_VER)/lib/libiriclib.so $(INSTALL_DIR)/iriclib-$(IRICLIB_VER)/lib/libiriclibd.so
	echo iriclib-build Done

iriclib-build-debug $(INSTALL_DIR)/iriclib-$(IRICLIB_VER)/lib/libiriclibd.so : $(SRC_DIR)/iriclib-$(IRICLIB_VER) $(INSTALL_DIR)/hdf5-$(HDF5_VER)/lib/libhdf5_debug.so $(INSTALL_DIR)/poco-$(POCO_VER)/lib/libPocoFoundationd.so
	rm -rf $(BUILD_DIR)/iriclib-$(IRICLIB_VER)/debug
	ctest -S iriclib.cmake -DCONF_DIR:STRING=debug -D"CTEST_CMAKE_GENERATOR:STRING=$(GENERATOR)" -C Debug -VV -O $(LOG_DIR)/$(SGEN)-iriclib-debug.log

iriclib-build-release $(INSTALL_DIR)/iriclib-$(IRICLIB_VER)/lib/libiriclib.so : $(SRC_DIR)/iriclib-$(IRICLIB_VER) $(INSTALL_DIR)/hdf5-$(HDF5_VER)/lib/libhdf5.so $(INSTALL_DIR)/poco-$(POCO_VER)/lib/libPocoFoundation.so
	rm -rf $(BUILD_DIR)/iriclib-$(IRICLIB_VER)/release
	ctest -S iriclib.cmake -DCONF_DIR:STRING=release -D"CTEST_CMAKE_GENERATOR:STRING=$(GENERATOR)" -C Release -VV -O $(LOG_DIR)/$(SGEN)-iriclib-release.log

iriclib-src $(SRC_DIR)/iriclib-$(IRICLIB_VER) : $(DOWNLOADS_DIR)/iriclib-$(IRICLIB_VER).zip
	7z x $(DOWNLOADS_DIR)/iriclib-$(IRICLIB_VER).zip -o$(SRC_DIR)
	mv $(SRC_DIR)/iriclib_v4-$(IRICLIB_VER) $(SRC_DIR)/iriclib-$(IRICLIB_VER)
	touch $(SRC_DIR)/iriclib-$(IRICLIB_VER)

iriclib-download $(DOWNLOADS_DIR)/iriclib-$(IRICLIB_VER).zip :
	$(MKDIR) $(DOWNLOADS_DIR)
	cd $(DOWNLOADS_DIR) && $(CURL) https://github.com/i-RIC/iriclib_v4/archive/v$(IRICLIB_VER).zip
	mv $(DOWNLOADS_DIR)/v$(IRICLIB_VER).zip $(DOWNLOADS_DIR)/iriclib-$(IRICLIB_VER).zip


# poco


poco_opts  = -D"CTEST_PROJECT_NAME:STRING=poco"
poco_opts += -D"CTEST_PROJECT_VERSION:STRING=$(POCO_VER)"
poco_opts += -D"CTEST_SOURCE_DIRECTORY:PATH=lib/src/poco-$(POCO_VER)"

poco_opts_debug  = $(poco_opts)
poco_opts_debug += -D"CTEST_BINARY_DIRECTORY:PATH=lib/build/poco-$(POCO_VER)/debug"
poco_opts_debug += -D"CTEST_CMAKE_GENERATOR:STRING=$(GENERATOR)"

poco-build : $(INSTALL_DIR)/poco-$(POCO_VER)/lib/libPocoFoundation.so $(INSTALL_DIR)/poco-$(POCO_VER)/lib/libPocoFoundationd.so
	echo poco-build Done

poco-build-debug $(INSTALL_DIR)/poco-$(POCO_VER)/lib/libPocoFoundationd.so : $(SRC_DIR)/poco-$(POCO_VER)
	$(MKDIR) $(INSTALL_DIR)
	ctest -S poco.cmake $(poco_opts_debug) -C Debug -VV -O $(LOG_DIR)/$(SGEN)-poco-debug.log

poco_opts_release  = $(poco_opts)
poco_opts_release += -D"CTEST_BINARY_DIRECTORY:PATH=lib/build/poco-$(POCO_VER)/release"
poco_opts_release += -D"CTEST_CMAKE_GENERATOR:STRING=$(GENERATOR)"

poco-build-release $(INSTALL_DIR)/poco-$(POCO_VER)/lib/libPocoFoundation.so : $(SRC_DIR)/poco-$(POCO_VER)
	$(MKDIR) $(INSTALL_DIR)
	ctest -S poco.cmake $(poco_opts_release) -C Release -VV -O $(LOG_DIR)/$(SGEN)-poco-release.log

poco-src $(SRC_DIR)/poco-$(POCO_VER) : $(DOWNLOADS_DIR)/poco-$(POCO_VER)-release.zip
	7z x $(DOWNLOADS_DIR)/poco-$(POCO_VER)-release.zip -o$(SRC_DIR)
	mv $(SRC_DIR)/poco-poco-$(POCO_VER)-release $(SRC_DIR)/poco-$(POCO_VER)
	touch $(SRC_DIR)/poco-$(POCO_VER)

poco-download $(DOWNLOADS_DIR)/poco-$(POCO_VER)-release.zip :
	$(MKDIR) $(DOWNLOADS_DIR)
	cd $(DOWNLOADS_DIR) && $(CURL) https://github.com/pocoproject/poco/archive/poco-$(POCO_VER)-release.zip


# hdf5


hdf5-build : $(INSTALL_DIR)/hdf5-$(HDF5_VER)/lib/libhdf5.so $(INSTALL_DIR)/hdf5-$(HDF5_VER)/lib/libhdf5_debug.so
	echo hdf5-build Done

hdf5-build-debug $(INSTALL_DIR)/hdf5-$(HDF5_VER)/lib/libhdf5_debug.so : $(SRC_DIR)/CMake-hdf5-$(HDF5_VER)
	$(MKDIR) $(INSTALL_DIR)
	ctest -S hdf5.cmake -DCONF_DIR:STRING=debug -D"CTEST_CMAKE_GENERATOR:STRING=Unix Makefiles" -C Debug -VV -O $(LOG_DIR)/make-hdf5-debug.log
	cd lib/build/hdf5-$(HDF5_VER)/debug && cpack -C Debug -G ZIP
	cd lib/build/hdf5-$(HDF5_VER)/debug && rsync -a _CPack_Packages/Linux/ZIP/HDF5-$(HDF5_VER)-Linux/HDF_Group/HDF5/$(HDF5_VER)/ ../../../install/hdf5-$(HDF5_VER)

hdf5-build-release $(INSTALL_DIR)/hdf5-$(HDF5_VER)/lib/libhdf5.so : $(SRC_DIR)/CMake-hdf5-$(HDF5_VER)
	$(MKDIR) $(INSTALL_DIR)
	ctest -S hdf5.cmake -DCONF_DIR:STRING=release -D"CTEST_CMAKE_GENERATOR:STRING=Unix Makefiles" -C Release -VV -O $(LOG_DIR)/make-hdf5-release.log
	cd lib/build/hdf5-$(HDF5_VER)/release && cpack -C Release -G ZIP
	cd lib/build/hdf5-$(HDF5_VER)/release && rsync -a _CPack_Packages/Linux/ZIP/HDF5-$(HDF5_VER)-Linux/HDF_Group/HDF5/$(HDF5_VER)/ ../../../install/hdf5-$(HDF5_VER)

hdf5-src $(SRC_DIR)/CMake-hdf5-$(HDF5_VER) : $(DOWNLOADS_DIR)/CMake-hdf5-$(HDF5_VER).zip
	7z x $(DOWNLOADS_DIR)/CMake-hdf5-$(HDF5_VER).zip -o$(SRC_DIR)
	touch $(SRC_DIR)/CMake-hdf5-$(HDF5_VER)

hdf5-download $(DOWNLOADS_DIR)/CMake-hdf5-$(HDF5_VER).zip :
	$(MKDIR) $(DOWNLOADS_DIR)
	cd $(DOWNLOADS_DIR) && $(CURL) https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$(HDF5_MAJMIN)/hdf5-$(HDF5_VER)/src/CMake-hdf5-$(HDF5_VER).zip


# VTK

# libvtk9-dev
# sudo apt install libvtk9-dev


# vtk-build : $(INSTALL_DIR)/vtk-$(VTK_VER)/release/lib/libvtkCommonCore-$(VTK_MAJMIN).so $(INSTALL_DIR)/vtk-$(VTK_VER)/debug/lib/libvtkCommonCore-$(VTK_MAJMIN).so
# 	echo vtk-build Done

# # vtk-build-release $(INSTALL_DIR)/vtk-$(VTK_VER)/release/lib/libvtkCommonCore-$(VTK_MAJMIN).so : $(SRC_DIR)/VTK-$(VTK_VER)
# # 	$(MKDIR) $(INSTALL_DIR)
# # 	ctest -S vtk.cmake -DCONF_DIR:STRING=release -D"CTEST_CMAKE_GENERATOR:STRING=Unix Makefiles" -C Release -VV -O $(LOG_DIR)/make-vtk-release.log

# vtk-build-release : $(INSTALL_DIR)/vtk-$(VTK_VER)/release/lib/libvtkCommonCore-$(VTK_MAJMIN).so

# $(INSTALL_DIR)/vtk-$(VTK_VER)/release/lib/libvtkCommonCore-$(VTK_MAJMIN).so : $(SRC_DIR)/VTK-$(VTK_VER)
# 	$(MKDIR) $(INSTALL_DIR)
# 	ctest -S vtk.cmake -DCONF_DIR:STRING=release -D"CTEST_CMAKE_GENERATOR:STRING=Unix Makefiles" -C Release -VV -O $(LOG_DIR)/make-vtk-release.log

# # vtk-build-debug $(INSTALL_DIR)/vtk-$(VTK_VER)/debug/lib/libvtkCommonCore-$(VTK_MAJMIN).so : $(SRC_DIR)/VTK-$(VTK_VER)
# # 	$(MKDIR) $(INSTALL_DIR)
# # 	ctest -S vtk.cmake -DCONF_DIR:STRING=debug -D"CTEST_CMAKE_GENERATOR:STRING=Unix Makefiles" -C Debug -VV -O $(LOG_DIR)/make-vtk-debug.log

# vtk-build-debug : $(INSTALL_DIR)/vtk-$(VTK_VER)/debug/lib/libvtkCommonCore-$(VTK_MAJMIN).so

# $(INSTALL_DIR)/vtk-$(VTK_VER)/debug/lib/libvtkCommonCore-$(VTK_MAJMIN).so : $(SRC_DIR)/VTK-$(VTK_VER)
# 	$(MKDIR) $(INSTALL_DIR)
# 	ctest -S vtk.cmake -DCONF_DIR:STRING=debug -D"CTEST_CMAKE_GENERATOR:STRING=Unix Makefiles" -C Debug -VV -O $(LOG_DIR)/make-vtk-debug.log

# vtk-src $(SRC_DIR)/VTK-$(VTK_VER) : $(DOWNLOADS_DIR)/VTK-$(VTK_VER).zip
# 	7z x $(DOWNLOADS_DIR)/VTK-$(VTK_VER).zip -o$(SRC_DIR)
# 	touch $(SRC_DIR)/VTK-$(VTK_VER)

# vtk-download $(DOWNLOADS_DIR)/VTK-$(VTK_VER).zip :
# 	$(MKDIR) $(DOWNLOADS_DIR)
# 	cd $(DOWNLOADS_DIR) && $(CURL) https://www.vtk.org/files/release/$(VTK_MAJMIN)/VTK-$(VTK_VER).zip
