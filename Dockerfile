# # FROM ubuntu

# # # Install necessary packages
# # #============================
# # RUN apt-get update && apt-get install -y 
# # RUN apt install openjdk-17-jre-headless -y
# # RUN apt install maven -y

# # # Set the working directory
# # WORKDIR /app

# # # Copy source files and pom.xml
# # COPY application.properties /app/src/main/resources/application.properties
# # COPY ./src /app/src
# # COPY ./pom.xml /app

# # # Build the application
# # RUN mvn -f /app/pom.xml clean package
# # RUN ls -la /app/target
# # # Copy the built JAR file to the container


# # EXPOSE 8080

# # ENTRYPOINT ["java", "-jar", "app.jar"]




# # # ==========================
# # # FROM eclipse-temurin:25
# # # RUN mkdir /opt/app
# # # COPY japp.jar /opt/app
# # # CMD ["java", "-jar", "/opt/app/japp.jar"]
# FROM ubuntu

# RUN apt-get update && apt-get install -y \
#     openjdk-17-jre-headless \
#     maven && \
#     rm -rf /var/lib/apt/lists/*

# WORKDIR /app

# COPY pom.xml .
# COPY src ./src
# COPY .env /app/src/main/resources/.env

# RUN export $(cat .env | xargs) && mvn clean package

# RUN cp target/*.jar app.jar

# EXPOSE 8080

# ENTRYPOINT ["java", "-jar", "app.jar"]


# FROM ubuntu

# RUN apt-get update && apt-get install -y \
#     openjdk-17-jre-headless \
#     maven && \
#     rm -rf /var/lib/apt/lists/*

# WORKDIR /app

# COPY pom.xml .
# COPY src ./src

# # Copy the .env file created by GitHub Actions into the image
# COPY .env .env

# # Use 'set -a' to export variables correctly before running maven
# RUN set -a && . ./.env && set +a && mvn clean package

# RUN cp target/*.jar app.jar

# EXPOSE 8080

# ENTRYPOINT ["java", "-jar", "app.jar"]

FROM ubuntu

RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    maven && \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
COPY src ./src

# Accept value from GitHub Actions
ARG MONGO_URI

# Make it available to Spring Boot
ENV MONGO_URI=${MONGO_URI}

# Optional: debug (you can remove later)
RUN echo "MONGO_URI is set"

# Build (tests WILL run and use the env variable)
RUN mvn clean package

RUN cp target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]