#
# Specify the directory layout used in make build for SV.
# Any changes here require changes in include.mk & MakeHelpers/*.mk
#

# hardcoded the path for mitk build since CTK exceeds allowable path limit
# (46 character prefix killed build)

# tcl
s+REPLACEME_SV_TOP_SRC_DIR_TCL+REPLACEME_SV_TOPLEVEL_SRCDIR/REPLACEME_SV_TCL_DIR+g
s+REPLACEME_SV_TOP_BLD_DIR_TCL+REPLACEME_SV_TOPLEVEL_BUILDDIR/REPLACEME_SV_COMPILER_BIN_DIR/REPLACEME_SV_ARCH_DIR/REPLACEME_SV_TCL_DIR+g
s+REPLACEME_SV_TOP_BIN_DIR_TCL+REPLACEME_SV_TOPLEVEL_BINDIR/REPLACEME_SV_COMPILER_BIN_DIR/REPLACEME_SV_ARCH_DIR/REPLACEME_SV_TCLTK_DIR+g
# tk
s+REPLACEME_SV_TOP_SRC_DIR_TK+REPLACEME_SV_TOPLEVEL_SRCDIR/REPLACEME_SV_TK_DIR+g
s+REPLACEME_SV_TOP_BLD_DIR_TK+REPLACEME_SV_TOPLEVEL_BUILDDIR/REPLACEME_SV_COMPILER_BIN_DIR/REPLACEME_SV_ARCH_DIR/REPLACEME_SV_TK_DIR+g
s+REPLACEME_SV_TOP_BIN_DIR_TK+REPLACEME_SV_TOPLEVEL_BINDIR/REPLACEME_SV_COMPILER_BIN_DIR/REPLACEME_SV_ARCH_DIR/REPLACEME_SV_TCLTK_DIR+g
# vtk
s+REPLACEME_SV_TOP_SRC_DIR_VTK+REPLACEME_SV_TOPLEVEL_SRCDIR/REPLACEME_SV_VTK_DIR+g
s+REPLACEME_SV_TOP_BLD_DIR_VTK+REPLACEME_SV_TOPLEVEL_BUILDDIR/REPLACEME_SV_COMPILER_BIN_DIR/REPLACEME_SV_ARCH_DIR/REPLACEME_SV_VTK_DIR+g
s+REPLACEME_SV_TOP_BIN_DIR_VTK+REPLACEME_SV_TOPLEVEL_BINDIR/REPLACEME_SV_COMPILER_BIN_DIR/REPLACEME_SV_ARCH_DIR/REPLACEME_SV_VTK_DIR+g

#
# toplevel directories
#

s+REPLACEME_SV_TOPLEVEL_SRCDIR+C:/cygwin64/usr/local/svsolver/externals/src+g
s+REPLACEME_SV_TOPLEVEL_BINDIR+C:/cygwin64/usr/local/svsolver/externals/bin+g
s+REPLACEME_NO_FIRST_SLASH_SV_TOPLEVEL_BINDIR+usr/local/svsolver/externals/bin+g
#s+REPLACEME_SV_TOPLEVEL_BUILDDIR+C:/cygwin64/usr/local/svsolver/externals/build+g
s+REPLACEME_SV_TOPLEVEL_BUILDDIR+C:/svsolver+g

#
#
#

s+REPLACEME_CC+CL+g
s/REPLACEME_CXX/CL/g
s/REPLACEME_TAR/tar/g
s/REPLACEME_ZIP/zip/g
s+REPLACEME_SV_SPECIAL_COMPILER_SCRIPT+source CygwinHelpers/msvc_2013_x64;export PATH=/cygdrive/c/Program\\ Files/doxygen/bin:/cygdrive/c/Program\\ Files/CMake/bin:$PATH+g
s+REPLACEME_SV_PLATFORM+windows+g
s+REPLACEME_SV_LIB_FILE_PREFIX++g
s+REPLACEME_SV_LIB_FILE_EXTENSION+lib+g
s+REPLACEME_SV_SO_FILE_EXTENSION+dll+g

# note: must use devenv for mitk
s+REPLACEME_SV_CMAKE_GENERATOR+"Visual Studio 12 2013 Win64"+g
s+REPLACEME_SV_MAKE_CMD+devenv.exe+g
s+REPLACEME_SV_MAKE_BUILD_PARAMETERS+/build REPLACEME_SV_CMAKE_BUILD_TYPE /project ALL_BUILD /projectconfig REPLACEME_SV_CMAKE_BUILD_TYPE /out ./stdout.devenv.build.txt+g
s+REPLACEME_SV_MAKE_INSTALL_PARAMETERS+/build REPLACEME_SV_CMAKE_BUILD_TYPE /project INSTALL /projectconfig REPLACEME_SV_CMAKE_BUILD_TYPE /out ./stdout.devenv.install.txt +g

s+REPLACEME_SV_CMAKE_BUILD_TYPE+RelWithDebInfo+g
s+REPLACEME_SV_CMAKE_CMD+/cygdrive/c/Program\\ Files/CMake/bin/cmake.exe+g
s+REPLACEME_SV_CMAKE_OBJECT_PATH_MAX+128+g

s+REPLACEME_SV_OS_DIR+win+g
s+REPLACEME_SV_COMPILER_BIN_DIR+msvc-12.5+g
s+REPLACEME_SV_ARCH_DIR+x64+g

# vtk

s+REPLACEME_SV_VTK_VERSION+vtk-6.2.0+g
s+REPLACEME_SV_VTK_DIR+vtk-6.2.0+g
s+REPLACEME_SV_VTK_CMAKE_LIB_DIR+lib/cmake/vtk-6.2+g
s+REPLACEME_SV_VTK_MAKE_FILENAME+vtk.sln+g

# Tcl/Tk

s+REPLACEME_SV_TCL_VERSION+8.6.4+g
s+REPLACEME_SV_TCLTK_DIR+tcltk-8.6.4+g
s+REPLACEME_SV_TCL_DIR+tcl-8.6.4+g
s+REPLACEME_SV_TCL_LIB_NAME+tcl86t.lib+g
s+REPLACEME_SV_TK_VERSION+8.6.4+g
s+REPLACEME_SV_TK_DIR+tk-8.6.4+g
s+REPLACEME_SV_TK_LIB_NAME+tk86t.lib+g
s+REPLACEME_SV_TCL_DLL_NAME+tcl86t.dll+g
s+REPLACEME_SV_TCL_DLL_DIR+bin+g
s+REPLACEME_SV_TK_DLL_NAME+tk86t.dll+g
s+REPLACEME_SV_TK_DLL_DIR+bin+g
s+REPLACEME_SV_TCLSH_EXECUTABLE+tclsh86t.exe+g
s+REPLACEME_SV_WISH_EXECUTABLE+wish86t.exe+g
