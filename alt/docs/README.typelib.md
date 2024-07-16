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

### Installing the package
To build a package from sources, you need to execute the following commands (from the root directory of the project):

```bash
gear-rpm -ba --verbose
```

Then you need to install the assembled packages on the system (libgvdb, libgvdb-devel, libgvdb-gir) using the `rpm -i` command:

```bash
rpm -i </path/to/.rpm file>
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

### Documentation
Once the package is built, the documentation for the bundling can be found in the `/usr/share/gvdb-doc/html/gvdb` directory.
To display it in the browser, you need to execute the following commands:

```bash
$BROWSER /usr/share/gvdb-doc/html/gvdb/index.html
```

 ---
###  Test case
The repository contains the file `gvdb_test.py`, where the available methods of the bundled library are tested.


The example is for the functionality we need to develop - reading policy binary files.

**Execution result**:
```bash
/Software/BaseALT/Policies/gsettings/                                          None
/Software/BaseALT/Policies/gsettings/org.mate.background.color-shading-type    'vertical-gradient'
/Software/BaseALT/                                                             None
/Software/BaseALT/Policies/ReadQueue/User/0                                    "('qwe1', '/var/cache/samba/gpo_cache/DOMAIN.TEST/POLICIES/{506A92C2-9C84-40CD-A950-FFEE42A9B0A5}', 131074)"
/Software/                                                                     None
/Software/BaseALT/Policies/ReadQueue/User/                                     None
/Software/BaseALT/Policies/ReadQueue/                                          None
/                                                                              None
/Software/BaseALT/Policies/                                                    None
```
