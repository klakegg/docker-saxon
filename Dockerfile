FROM openjdk:8-jre-alpine

ARG version=9.7.0-21

RUN wget -O /saxon.jar http://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/$version/Saxon-HE-$version.jar

VOLUME /src /target

WORKDIR /src
ENTRYPOINT ["java", "-jar", "/saxon.jar"]
