# Paso 1: Compilar la aplicación usando Maven 4 y OpenJDK 26 (Early Access / Canditate)
FROM maven:4.0.0-beta-3-openjdk-20 AS build
# Nota: Como las imágenes oficiales estables de Maven 4 + JDK 26 se están desplegando,
# usamos la base de contenedores más cercana o dejamos que Maven descargue el compilador dinámicamente.
COPY . .
RUN mvn clean package -DskipTests

# Paso 2: Levantar el archivo compilado con el entorno de ejecución de Java 26
FROM openjdk:26-jdk-slim
COPY --from=build /target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]