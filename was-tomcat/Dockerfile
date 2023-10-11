# Build stage
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app

# Copying the Maven project file and downloading the dependencies
COPY ./k8s-petclinic/pom.xml .
RUN mvn dependency:go-offline

# Downloading the source code and building the application
RUN git clone https://github.com/junnn0021/petclinic.git /tmp/petclinic_btc && \
    mv /tmp/petclinic_btc/src ./src && \
    rm -rf /tmp/petclinic_btc
RUN mvn package -P MySQL -DskipTests

# Final stage
FROM tomcat:9.0.53-jdk16-openjdk-slim

# Install MySQL client
RUN apt-get update && \
    apt-get install -y default-mysql-client && \
    apt-get clean

COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/
COPY init-database.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init-database.sh
EXPOSE 8080
CMD ["catalina.sh", "run"]