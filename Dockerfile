FROM ubuntu

RUN apt-get update && apt-get install -y \
    openjdk-17-jre-headless \
    maven \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
COPY src ./src

# ✅ Receive from GitHub Actions
ARG MONGO_URI

# ✅ Make available to Spring BEFORE build
ENV MONGO_URI=$MONGO_URI

# (Optional debug)
RUN echo "Mongo URI injected"

# ✅ Run tests with correct DB connection
RUN mvn clean package

RUN cp target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]