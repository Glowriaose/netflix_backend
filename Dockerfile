# FROM ubuntu

# # Install necessary packages
# #============================
# RUN apt-get update && apt-get install -y 
# RUN apt install openjdk-17-jre-headless -y
# RUN apt install maven -y

# # Set the working directory
# WORKDIR /app

# # Copy source files and pom.xml
# COPY application.properties /app/src/main/resources/application.properties
# COPY ./src /app/src
# COPY ./pom.xml /app

# # Build the application
# RUN mvn -f /app/pom.xml clean package
# RUN ls -la /app/target
# # Copy the built JAR file to the container


# EXPOSE 8080

# ENTRYPOINT ["java", "-jar", "app.jar"]




# # ==========================
# # FROM eclipse-temurin:25
# # RUN mkdir /opt/app
# # COPY japp.jar /opt/app
# # CMD ["java", "-jar", "/opt/app/japp.jar"]
FROM ubuntu

# Install necessary packages
RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    maven && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# 1. Copy the pom first
COPY ./pom.xml /app/pom.xml

# 2. Copy the ENTIRE src folder
# This automatically puts application.properties and .env 
# into /app/src/main/resources/ where Maven expects them.
COPY ./src /app/src

# 3. Build the application
RUN mvn clean package -DskipTests

# 4. Rename the jar
RUN cp /app/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
