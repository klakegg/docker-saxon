FROM alpine:3.10 AS saxon

ARG saxon_ver=9.9.1-5
#ARG saxon_ver2=9-9-1-5

ADD \
  http://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/${saxon_ver}/Saxon-HE-${saxon_ver}.jar \
  /saxon.jar
#ADD \
#  https://www.saxonica.com/download/SaxonPE${saxon_ver2}J.zip \
#  /saxon-pe.zip
#ADD \
#  https://www.saxonica.com/download/SaxonEE${saxon_ver2}J.zip \
#  /saxon-ee.zip

#RUN apk add --no-cache unzip \
# && unzip /saxon-pe.zip -d /saxon-pe \
# && unzip /saxon-ee.zip -d /saxon-ee


FROM klakegg/graalvm-native AS he-graalvm

COPY graal /src
COPY --from=saxon /saxon.jar /src/saxon.jar

RUN sh /src/build-HE.sh


FROM alpine:3.10 AS tmp

ADD files /files

COPY --from=saxon /saxon.jar /files/he/usr/share/java/saxon/saxon.jar
COPY --from=he-graalvm /target/bin/saxon /files/he-graal/bin/saxon
#COPY --from=saxon /saxon-pe /files/pe/usr/share/java/saxon
#COPY --from=saxon /saxon-ee /files/ee/usr/share/java/saxon

RUN chmod a+x /files/*/bin/* \
 && chmod a+r -R /files \
 && find /files -type f | sort

FROM scratch

COPY --from=tmp /files /
