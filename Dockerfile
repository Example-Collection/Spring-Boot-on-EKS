FROM openjdk:11-jdk AS builder
WORKDIR application
ARG JAR_FILE=build/libs/Spring-Boot-on-EKS-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:11-jdk
WORKDIR application

COPY --from=builder application/application.jar ./application.jar
RUN true
COPY --from=builder application/dependencies/ ./
RUN true
COPY --from=builder application/spring-boot-loader/ ./
RUN true
COPY --from=builder application/snapshot-dependencies/ ./
RUN true
COPY --from=builder application/application/ ./
RUN true

ENV TZ Asia/Seoul

ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
