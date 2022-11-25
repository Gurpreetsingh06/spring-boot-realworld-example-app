FROM openjdk:11-jdk
WORKDIR /app/
ADD build/libs/spring-boot-realworld-example-app-0.0.1-SNAPSHOT.jar boot.jar
EXPOSE 8080
ENV MYSQL_HOST=db
ENV MYSQL_USER=user
ENV MYSQL_PWD=password
ENV MYSQL_PORT=3306
CMD ["java", "-jar", "/app/boot.jar"]