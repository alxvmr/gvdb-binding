# SPDX-FileCopyrightText: 2022 Endless OS Foundation, LLC
# SPDX-License-Identifier: LGPL-2.1-or-later

project('gvdb', 'c',
    version: '0.0',
    meson_version: '>=0.54.0',
)

glib_dep = dependency('glib-2.0')
gio_dep = dependency('gio-2.0')
gobject_dep = dependency('gobject-2.0')

gvdb_sources = files('gvdb/gvdb-builder.c',
                     'gvdb/gvdb-reader.c')

gvdb_lib = shared_library('gvdb',
  gvdb_sources,
  gnu_symbol_visibility: 'default',
  c_args : ['-fPIC'],
  dependencies : [glib_dep, gio_dep, gobject_dep],
  link_args : ['-shared'],
  version : '1.0',
  install : true
)

