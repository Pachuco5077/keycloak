# Usa la imagen oficial de Keycloak como base
FROM quay.io/keycloak/keycloak:latest

# Cambia al usuario root para realizar configuraciones necesarias
USER root

# Copia configuraciones personalizadas (opcional)
# COPY ./custom-config /opt/keycloak/conf

# Cambia de nuevo al usuario de Keycloak
USER keycloak

# Expone el puerto predeterminado de Keycloak
EXPOSE 8080

# Establece el comando para iniciar Keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
