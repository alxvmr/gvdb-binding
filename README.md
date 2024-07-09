# Python binding for C gvdb library
This project is a Python binding of the [gvdb library](https://gitlab.gnome.org/GNOME/gvdb) designed to work with GVariant Database.

The [PyGObject](https://pygobject.gnome.org/) is used for bundling.

---
## Description
PyGObject uses GLib, GObject, GIRepository, libffi and other libraries to access the `C` library (`<lib_name>.so`) in combination with the additional metadata from the accompanying `.typelib` file (`<lib_name>-<lib_version>.typelib`) and dynamically provides a Python interface based on that information:

![](https://pygobject.gnome.org/_images/overview.svg)

To bind a `C` library (assuming you have a `.so` file), you need to write a `.gir` file, then compile it into a `.typelib` file, a binary file that contains the API library metadata used by PyGObject to generate Python bindings.

You can generate the `.typelib` file automatically by using the `g-ir-compiler` tool, which is part of the GObject Introspection project. To do this, you must first generate a `.gir` file using the `g-ir-scanner` tool (see the next section for an example of how to use the commands).

---
## Preparing the environment

![#c5f015](https://placehold.co/15x15/c5f015/c5f015.png) - means that the file is already in the repository, the playback step is given to understand the process.


### Installation of necessary packages (ALT Linux p10)

```bash
apt-get python3-module-pygobject-devel
apt-get install python3-module-pygobject3
apt-get install git gitk cmake rpm-build
apt-get install libcairo-devel
apt-get install python3-devel
apt-get install gem-gio2-devel
apt-get install libgio2.0-devel
apt-get install libgio-devel
apt-get install gobject-introspection
apt-get install gobject-introspection-devel
apt-get install libcairo-gobject
apt-get install libcairo-gobject-devel
apt-get install meson
```

### Activating a Python virtual environment for PyGObject
From the root of the repository, execute the commands:

```python
source pygobject/bin/activate
python3 -m pip install PyGObject
pip install --upgrade pip
python3 -m pip install PyGObject
```

### ![#c5f015](https://placehold.co/15x15/c5f015/c5f015.png) Compiling the .gir file
Execute the command from the `./gvdb/gvdb` directory (where gvdb.so is located):

```bash
LD_LIBRARY_PATH=./ g-ir-scanner --namespace=Gvdb --nsversion=1.0 --library=libgvdb.so --accept-unprefixed --output=Gvdb.gir --c-include="gvdb-format.h" *.h gvdb-builder.c gvdb-reader.c -I/usr/include/glib-2.0/ -I/usr/include/gio-unix-2.0/ -I/usr/lib64/glib-2.0/include/
```

### ![#c5f015](https://placehold.co/15x15/c5f015/c5f015.png)Creating a binary file (.gir -> .typelib)
Execute the command from the `./gvdb/gvdb` directory (where Gvdb.gir is located):

```bash
g-ir-compiler Gvdb.gir -o Gvdb-1.0.typelib 
```

### Move .typelib to girepository
The resulting Gvdb-1.0.typelib should be moved to the `/usr/lib64/girepository-1.0 directory`:

``` bash
cp Gvdb-1.0.typelib /usr/lib64/girepository-1.0/
```

### Setting the environment variable (GI_TYPELIB_PATH)
`GI_TYPELIB_PATH` must point to the directory containing the `.typelib` files:

```bash
GI_TYPELIB_PATH=/usr/lib64/girepository-1.0
```

### Import check
If all was successful, an import should be available from the `.py` file:

```python
import gi
gi.require_version("Gvdb", "1.0")

from gi.repository import Gvdb
```
 ---
###  Test case
The repository contains the file `gvdb_test.py`, where the available methods of the bundled library are tested.  There is a problem - not all methods are available (details in `gvdb_test.py`).

Assumption - `g-ir-scanner` incorrectly analyzed information about the gvdb library.

Solution:
1. Manually edit the `.gir`
2. Deal with incorrect behavior of auto-generation (`g-ir-scanner`)
