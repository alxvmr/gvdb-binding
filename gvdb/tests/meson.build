# SPDX-FileCopyrightText: 2024 Carlos Garnacho
# SPDX-License-Identifier: LGPL-2.1-or-later

gvdb_test_exec = executable(
  'gvdb',
  files('gvdb.c'),
  dependencies: [gvdb_dep, glib_dep, gio_dep, gobject_dep],
)

test(
  'gvdb',
  gvdb_test_exec,
)