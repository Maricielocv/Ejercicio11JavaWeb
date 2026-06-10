# Paso 1: Compilar la aplicación usando Maven y Java 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .

# Truco de ingeniería: Busca dónde está el pom.xml y compila desde esa subcarpeta
RUN cd $(dirname $(find . -name "pom.xml" | head -n 1)) && mvn clean package -DskipTests

# Paso 2: Levantar el archivo compilado en el entorno de ejecución oficial
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app

# Busca el archivo .war generado en cualquier subcarpeta de target y lo copia
RUN --mount=type=bind,from=build,source=/app,target=/src_app \
    cp $(find /src_app -name "*.war" | head -n 1) app.war

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]