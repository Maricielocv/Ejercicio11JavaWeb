# Paso 1: Compilar la aplicación usando Maven 3.9 y la versión de Java compatible en la nube
FROM maven:3.9.6-eclipse-temurin-21 AS build
COPY . .
RUN mvn clean package -DskipTests

# Paso 2: Levantar el archivo compilado en el entorno de ejecución oficial de Eclipse Temurin
FROM eclipse-temurin:21-jre-jammy
COPY --from=build /target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]