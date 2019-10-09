#!/bin/sh

# Clean target
if [ -e /target ]; then
  rm -rf /target/*
fi

# Create build folder
mkdir -p /target/build

# Compile class
javac \
  -classpath /src/saxon.jar \
  -d /target/build \
  /src/Main.java

# Generate jar
jar \
  -cfe /target/build/main.jar Main \
  -C /target/build \
  Main.class

# Create native image
native-image \
  --static \
  --no-fallback \
  --allow-incomplete-classpath \
  -jar /src/saxon.jar \
  -jar /target/build/main.jar \
  -H:Name=/target/bin/saxon \
  -H:+ReportExceptionStackTraces \
  -H:ReflectionConfigurationFiles=/src/Saxon-HE.json \
  -H:ResourceConfigurationFiles=/src/Saxon-HE-res.json \
  -H:IncludeResourceBundles=com.sun.org.apache.xerces.internal.impl.msg.XMLMessages
