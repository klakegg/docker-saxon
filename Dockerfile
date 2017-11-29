FROM openjdk:8u151-jre

RUN wget -O /saxon.jar http://repo1.maven.org/maven2/net/sf/saxon/Saxon-HE/9.7.0-20/Saxon-HE-9.7.0-20.jar

VOLUME /src /target

WORKDIR /src
ENTRYPOINT ["java", "-jar", "/saxon.jar"]
