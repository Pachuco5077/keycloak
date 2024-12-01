# Primera etapa: Construir el proyecto con Maven
FROM maven:3.8.5-openjdk-17 AS build

# Copiar el código fuente de Keycloak
COPY . /keycloak

# Cambiar al directorio del proyecto
WORKDIR /keycloak

# Construir el proyecto usando Maven
RUN mvn clean install -DskipTests

# Segunda etapa: Usar la imagen base oficial de Keycloak
FROM quay.io/keycloak/keycloak:latest

# Copiar los artefactos construidos al contenedor final
COPY --from=build /keycloak/quarkus-app/ /opt/keycloak/

# Cambiar al usuario de Keycloak
USER keycloak

# Exponer el puerto predeterminado
EXPOSE 8080

# Comando para iniciar Keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
