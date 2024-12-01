# Usa un entorno base con JDK
FROM maven:3.8.5-openjdk-17 AS build

# Copia el código fuente de Keycloak al contenedor
COPY . /keycloak

# Cambia al directorio del proyecto
WORKDIR /keycloak

# Compila el código y construye el proyecto
RUN mvn clean install -DskipTests

# Usa la imagen base de Keycloak para la ejecución
FROM quay.io/keycloak/keycloak:latest

# Copia el artefacto construido al contenedor final
COPY --from=build /keycloak/dist /opt/keycloak

# Cambiar al usuario keycloak
USER keycloak

# Expone el puerto predeterminado
EXPOSE 9090

# Comando para iniciar Keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
