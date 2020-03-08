# Saxon

[![](https://images.microbadger.com/badges/image/klakegg/saxon.svg)](https://microbadger.com/images/klakegg/saxon )
![Build](https://github.com/klakegg/docker-saxon/workflows/Build/badge.svg)

This projects creates Docker images containing [Saxon](http://saxon.sourceforge.net/).

The following commands may be used:

* `xslt` - Triggering XSLT commands.
* `xquery` - Triggering Xquery commands.
* `saxon` - Used by `xslt` and `xquery` to trigger Saxon.

Example:

```bash
docker run --rm -i \
    -u $(id -u) \
    -v $(pwd):/src \
    klakegg/saxon \
    xslt -s:input.xml -xsl:transformer.xslt -o:output.xml
```

Please see the Saxon documentation for information about [XSLT commands](http://www.saxonica.com/documentation/#!using-xsl/commandline) and [XQuery commands](http://www.saxonica.com/documentation/#!using-xquery/commandline).


## Running Saxon with license

Owners of a Saxon license may use `EE` and `PE` images. The license file need to be made available inside the container to enable the licensed functionality.

Example of compiling XSLT file:

```bash
docker run --rm -i \
    -u $(id -u) \
    -v $(pwd):/src \
    -v $(pwd)/saxon-license.lic:/usr/share/java/saxon/saxon-license.lic \
    klakegg/saxon:ee \
    xslt-compile stylesheet.xslt JS stylesheet.js.sef
```
