FROM ubuntu

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    maven && \
    rm -rf /var/lib/apt/lists/*

# Setting the working DIR
WORKDIR /app

# 1. Copy the pom.xml (Required for Maven)
COPY ./pom.xml /app/pom.xml

# 2. Copy ONLY the specific config files from their subfolders
# Syntxt: COPY <path_in_repo> <path_in_container>
COPY ./src/main/resources/application.properties /app/src/main/resources/application.properties
COPY ./src/main/resources/.env /app/src/main/resources/.env

# 3.  copy only specific java folder that folder 
# (e.g., usually everything under src/main/java)
COPY ./src/main/java /app/src/main/java

# 4. Building the app
RUN mvn clean package -DskipTests

# 5. Prepare the final jar
RUN mv /app/target/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]