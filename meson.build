# SPDX-FileCopyrightText: 2022 Endless OS Foundation, LLC
# SPDX-License-Identifier: LGPL-2.1-or-later

project('gvdb', 'c',
    version: '0.0',
    meson_version: '>=0.56.0',
)

glib_dep = dependency('glib-2.0')
gio_dep = dependency('gio-2.0')
gobject_dep = dependency('gobject-2.0')

gvdb_sources = files('gvdb/gvdb-builder.c',
                     'gvdb/gvdb-reader.c')

include_dir = include_directories('.')

gvdb_lib = shared_library('gvdb',
  sources: gvdb_sources,
  include_directories: include_dir,
  gnu_symbol_visibility: 'default',
  c_args : ['-fPIC'],
  dependencies : [glib_dep, gio_dep, gobject_dep],
  link_args : ['-shared'],
  version : '0.0',
  install : true
)

gvdb_dep = declare_dependency(
  sources: gvdb_sources,
  include_directories: include_dir,
)

meson.override_dependency('gvdb', gvdb_dep)

pkg = import('pkgconfig')

subdir('gvdb/tests')

pkg.generate(
  gvdb_lib,
  version: meson.project_version(),
  name: 'gvdb',
  description: 'GVDB (GVariant Database) is a simple database file format that stores a mapping from strings to GVariant values in a way that is extremely efficient for lookups.',
  extra_cflags : ['-I${includedir}/gvdb'],
  variables: {
    'datadir': '${prefix}/' + get_option('datadir'),
  },
)