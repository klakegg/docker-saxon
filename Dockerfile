FROM alpine:3.10 AS saxon

ARG saxon_ver=9.9.1-5
#ARG saxon_ver=9.8.0-15

ADD \
  http://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/${saxon_ver}/Saxon-HE-${saxon_ver}.jar \
  /tmp/

RUN mv /tmp/Saxon-HE-${saxon_ver}.jar /saxon.jar


FROM klakegg/graalvm-native AS graalvm

COPY graal /src
COPY --from=saxon /saxon.jar /src/saxon.jar

RUN sh /src/build.sh


FROM alpine:3.10 AS tmp

ADD files /files

COPY --from=saxon /saxon.jar /files/he/usr/share/java/saxon.jar
COPY --from=graalvm /target/bin/saxon /files/graal/bin/saxon

RUN chmod a+x /files/*/bin/* \
 && chmod a+r /files/he/usr/share/java/saxon.jar


FROM scratch

COPY --from=tmp /files /
