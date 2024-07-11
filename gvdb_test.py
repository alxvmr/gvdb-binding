import gi
gi.require_version("Gvdb", "1.0")
gi.require_version("GLib", "2.0")

from gi.repository import Gvdb
from gi.repository import GLib

path_bin = "/etc/dconf/db/policy1506600500"

def show(names, values):
    max_n = -1
    max_v = -1
    for n, v in zip(names, values):
        if n:
          l = len(n)
          if l > max_n:
              max_n = l
        if v:
            l = len(v)
            if l > max_v:
                max_v = l
    max_n += 3
    for n, v in zip(names, values):
        print("{:{max_n}s} {:{max_v}s}".format(str(n), str(v), max_n=max_n, max_v=max_v))


if __name__ == "__main__":
  if (GLib.file_get_contents (path_bin)[0]):
      local_error = GLib.GError(None)
      bytes = GLib.Bytes.new(GLib.file_get_contents (path_bin)[1])
      table = Gvdb.Table.new_from_bytes(bytes, True)

      name_list = Gvdb.Table.get_names(table)
      value_list = []
      for name in name_list:
          value = Gvdb.Table.get_value(table, name)
          value_list.append(value)

      show(name_list, value_list)
    