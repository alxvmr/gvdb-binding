import gi
gi.require_version("Gvdb", "1.0")
gi.require_version("GLib", "2.0")

from gi.repository import Gvdb
from gi.repository import GLib

path_bin = "/etc/dconf/db/policy1506600500"

'''
TODO: Translate code into Python

void read_bin(const char *path){
    GError my_error = NULL;
    GvdbTable *table = NULL;
    gchar *contents;
    gsize size;

    if (g_file_get_contents (path, &contents, &size, &my_error))
    {
      GBytes *bytes;

      bytes = g_bytes_new_take (contents, size);
      table = gvdb_table_new_from_bytes (bytes, FALSE, &my_error);
      g_bytes_unref (bytes);
    }
    printf("Hello world!");

}
'''

if (GLib.file_get_contents (path_bin)[0]):
    bytes = GLib.file_get_contents (path_bin)[1]
    # table = Gvdb.Table.new_from_bytes(bytes, False)     // AttributeError: type object 'Table' has no attribute 'new_from_bytes' //