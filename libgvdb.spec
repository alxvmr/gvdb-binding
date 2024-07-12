%define _unpackaged_files_terminate_build 1
%def_without docs

Name: libgvdb
Version: 1.0.0
Epoch: 1
Release: alt1

Summary: Python binding (PyGObject) of GVDB library
License: LGPLv2.1
Group: System/Libraries
URL: https://gitlab.gnome.org/GNOME/gvdb

Source: gvdb-%version.tar

BuildRequires: git gitk cmake rpm-build
BuildRequires: python3-module-pygobject-devel python3-module-pygobject3 python3-devel
BuildRequires: libcairo-devel libcairo-gobject libcairo-gobject-devel
BuildRequires: libgio-devel gobject-introspection gobject-introspection-devel gem-gio2-devel
BuildRequires: meson

%description
GVDB (GVariant Database) is a simple database file format that stores a mapping from strings to GVariant values in a way that is extremely efficient for lookups.

%package devel
Summary: Headers for developing programs that will use gvdb
Group: Development/C
Requires: %name = %epoch:%version-%release

%description devel
GVDB is a library for working with the GVariant database.
This package contains the headers that programmers will need to develop applications using the gvdb library.
applications that use the gvdb library.

%package gir
Summary: GObject introspection data for the Gvdb-1.0 library
Group: System/Libraries
Requires: %name = %epoch:%version-%release

%description gir
GObject introspection data for the Gvdb-1.0 library

%prep
%setup -q -n gvdb-%version

%build
cd gvdb
%meson \
        -Dfreetype=enabled \
        -Dfontconfig=enabled \
        -Dglib=enabled \
        -Dxlib=enabled \
        -Dxcb=enabled \
        -Dtee=enabled \
        -Dsymbol-lookup=disabled \
        -Dspectre=disabled \
%if_with docs
        -Dgtk_doc=true \
%endif
        -Dtests=disabled \
%meson_build

cd gvdb
LD_LIBRARY_PATH=./ g-ir-scanner --namespace=Gvdb --nsversion=1.0 --include GLib-2.0 --include Gio-2.0 -L . --library=libgvdb.so --accept-unprefixed --output=Gvdb.gir --c-include="gvdb-format.h" *.h *.c -I/usr/include/glib-2.0/ -I/usr/include/gio-unix-2.0/ -I/usr/lib64/glib-2.0/include --warn-all
g-ir-compiler Gvdb.gir -o Gvdb-1.0.typelib 

%install
%meson_install

%files
%_libdir/%name.so.*

%files devel
%_includedir/gvdb
%_libdir/%name.so

%files gir
%_typelibdir/*.typelib
%changelog
* Fri Jul 12 2024 Maria Alexeeva <alxvmr@altlinux.org> 1:1.0.0-alt1
- first build

