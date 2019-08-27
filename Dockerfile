FROM alpine:3.10 AS prepare

ARG saxon_ver=9.9.1-2
#ARG saxon_ver=9.8.0-15

ADD \
  http://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/${saxon_ver}/Saxon-HE-${saxon_ver}.jar \
  /tmp/

ADD image /image

RUN echo \
  # Saxon
  && mv /tmp/Saxon-HE-${saxon_ver}.jar /image/saxon.jar \
  && chmod a+r /image/saxon.jar \
  # Executables
  && chmod a+x /image/bin/* \
  # List content
  && find /image


FROM scratch

COPY --from=prepare /image /
