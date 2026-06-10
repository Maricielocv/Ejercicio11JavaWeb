# Paso 1: Compilar la aplicación usando Maven y Amazon Corretto Java 26
FROM maven:3.9.9-amazoncorretto-26-al2023 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Paso 2: Levantar el archivo compilado usando el entorno de ejecución oficial de Amazon Corretto 26
FROM amazoncorretto:26-al2023-headless
WORKDIR /app
COPY --from=build /app/target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]