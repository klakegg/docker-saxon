FROM alpine:3.11 AS saxon

ARG saxon_ver=9.9.1-7
ARG saxon_ver2=9-9-1-7

ADD \
  https://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/${saxon_ver}/Saxon-HE-${saxon_ver}.jar \
  /saxon.jar
ADD \
  https://www.saxonica.com/download/SaxonPE${saxon_ver2}J.zip \
  /saxon-pe.zip
ADD \
  https://www.saxonica.com/download/SaxonEE${saxon_ver2}J.zip \
  /saxon-ee.zip

RUN apk add --no-cache unzip \
 && unzip -q /saxon-pe.zip -d /saxon-pe \
 && unzip -q /saxon-ee.zip -d /saxon-ee


FROM klakegg/graalvm-native:20.0.0 AS he-graalvm

COPY graal /src
COPY --from=saxon /saxon.jar /src/saxon.jar

RUN sh /src/build-HE.sh


FROM alpine:3.11 AS tmp

ADD files /files

# Java
COPY --from=saxon /saxon.jar /files/he/usr/share/java/saxon/saxon.jar
COPY --from=saxon /saxon-pe /files/pe/usr/share/java/saxon
COPY --from=saxon /saxon-ee /files/ee/usr/share/java/saxon

# Native
COPY --from=he-graalvm /target/bin/saxon /files/he-graal/bin/saxon

RUN chmod a+x /files/*/bin/* \
 && chmod a+r -R /files \
 && find /files -type f | sort

FROM scratch

COPY --from=tmp /files /
