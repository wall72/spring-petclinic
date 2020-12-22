FROM maven:3.6.3-jdk-11 as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:11.0.9.1-jdk
COPY --from=builder /app/target/spring-petclinic-*.jar /spring-petclinic.jar
ENV PORT 8080
CMD ["java","-Dserver.port=${PORT}","-jar","/spring-petclinic.jar"]
