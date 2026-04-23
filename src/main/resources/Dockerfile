FROM ubuntu

RUN apt-get update && apt-get install -y
RUN apt install openjdk-17-jre-headless -y
RUN apt install maven -y

# setting the working DIR
WORKDIR /app

# Copying files to the working dir.
COPY ./src /app/src
COPY  ./pom.xml /app

# building the app
RUN mvn -f /app/pom.xml clean package -DskipTests
RUN ls -la /app/target

# copy the built artifac files to the container
COPY ./target/*.jar /app/app.jar
WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

#FROM eclipse-temurin
#RUN mkdir /opt/app
#COPY    japp.jar /opt/app
C#MD ["java", "jar", "/opt/app/japp.jar"]