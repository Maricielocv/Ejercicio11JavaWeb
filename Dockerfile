# Paso 1: Build con Maven
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Paso 2: Ejecutar con Tomcat (OBLIGATORIO para JSP/Servlet)
FROM tomcat:10.1-jdk21

COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080