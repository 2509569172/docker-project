FROM orange2019/jdk-8u201:20190906

WORKDIR /orangeiot/gw_log/
WORKDIR /orangeiot/

COPY gwlog-1.0-SNAPSHOT.jar /orangeiot/gwlog-1.0-SNAPSHOT.jar

EXPOSE 5555

ENTRYPOINT ["sh","-c","java -jar /orangeiot/gwlog-1.0-SNAPSHOT.jar 5555 /orangeiot/gw_log/ false"]
