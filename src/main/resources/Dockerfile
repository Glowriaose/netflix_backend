FROM ubuntu

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    maven && \
    rm -rf /var/lib/apt/lists/*

# Setting the working DIR
WORKDIR /app

# Copying files
# This copies the entire src folder, which includes the application.properties 
# and .env since they are inside src/main/resources
COPY ./src /app/src
COPY ./pom.xml /app

# Building the app
RUN mvn clean package -DskipTests

# Important: Maven creates the file "netflix_backend-0.0.1-SNAPSHOT.jar"
# finds it and rename it to app.jar so the ENTRYPOINT works
RUN mv /app/target/*.jar /app/app.jar

EXPOSE 8080

# Use the renamed jar
ENTRYPOINT ["java", "-jar", "/app/app.jar"]