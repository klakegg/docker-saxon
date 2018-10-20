FROM alpine:3.8 AS prepare

ARG saxon_ver=9.8.0-14
ARG schematron_ver=e16ecc490f9c6429f275ea268279787a71ff298f

ADD \
  http://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/${saxon_ver}/Saxon-HE-${saxon_ver}.jar \
  https://github.com/Schematron/schematron/archive/${schematron_ver}.tar.gz \
  /tmp/

ADD image /image

RUN echo \
  # Saxon
  && mv /tmp/Saxon-HE-${saxon_ver}.jar /image/saxon.jar \
  # Schematron
  && tar -xzf /tmp/${schematron_ver}.tar.gz -C /tmp \
  && mv /tmp/schematron-${schematron_ver}/trunk/schematron/code /image/schematron \
  && rm /image/schematron/*.*htm* /image/schematron/*xslt1.xsl \
  # Executables
  && chmod a+x /image/bin/*



FROM openjdk:8u171-alpine

COPY --from=prepare /image /

RUN apk --no-cache add zip gettext

VOLUME /src /target

WORKDIR /src
