FROM ubuntu

# Install necessary packages
RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    maven && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# 1. Copy the config from the ACTUAL path in your repo
COPY ./src/main/resources/application.properties /app/src/main/resources/application.properties
COPY ./src/main/resources/.env /app/src/main/resources/.env

# 2. Copy the rest of the source and pom
COPY ./src /app/src
COPY ./pom.xml /app/pom.xml

# 3. Build the application
RUN mvn clean package -DskipTests

# 4. Critical Step: Maven doesn't name the jar "app.jar"
# We must rename the generated jar so the ENTRYPOINT can find it
RUN cp /app/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]