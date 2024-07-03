cmake_minimum_required(VERSION 3.5)
project(gvdb)

FIND_PACKAGE(PkgConfig)
PKG_CHECK_MODULES(GLIB glib-2.0 gio-2.0 REQUIRED)
include_directories(${GLIB_INCLUDE_DIRS})
link_directories(${GLIB_LIBRARY_DIRS})

set(SOURCE_LIB gvdb-builder.c gvdb-reader.c gvdb-builder.h gvdb-reader.h gvdb-format.h)

set(LIBRARY_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/bin/")

add_library(gvdb ${SOURCE_LIB})
target_include_directories(gvdb PUBLIC ${GLIB_LIBRARIES})
