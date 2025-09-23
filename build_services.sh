#!/bin/bash
# build-all-services.sh
# Script para construir los JARs e imágenes Docker de todos los servicios y levantar los contenedores
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH


docker image prune -f  # Limpiar imágenes no utilizadas
docker container prune -f  # Limpiar contenedores detenidos
docker volume prune -f  # Limpiar volúmenes no utilizados
docker network prune -f  # Limpiar redes no utilizadas

set -e  # Detener en caso de error

# Colores para mejor legibilidad
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Salvar en variable el directorio en el que me encuentro
CURRENT_DIR="$PWD"

cd .. # Cambiar al directorio padre para asegurar que estamos en el contexto correcto

# Directorio base donde están todos los repositorios
BASE_DIR="$PWD"
echo -e "${YELLOW}Directorio base: $BASE_DIR${NC}"

# Lista de todos los servicios a construir
SERVICES=(
    "user-service"
    "schedule-consumer-service"
    "mail-service"
    "eureka-service"
    "auth-service"
    "api-gateway"
    "academic-subscription-service"
    "statistics-service"
)

build_service() {
    local service=$1
    echo -e "\n${YELLOW}=======================================${NC}"
    echo -e "${YELLOW}Construyendo $service${NC}"
    echo -e "${YELLOW}=======================================${NC}"
    
    # Verificar si el directorio existe
    if [ ! -d "$service" ]; then
        echo -e "${RED}Error: El directorio $service no existe${NC}"
        return 1
    fi
    
    # Entrar al directorio del servicio
    cd "$service"
    
    # Eliminar el directorio target si existe (solución al error de Maven clean)
    if [ -d "target" ]; then
        rm -rf target
    fi
    
    # Construir el JAR siempre con Maven global
    echo -e "${GREEN}Ejecutando Maven para $service...${NC}"
    mvn clean package -DskipTests

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}JAR de $service construido correctamente${NC}"
    else
        echo -e "${RED}Error al construir el JAR de $service${NC}"
        cd "$BASE_DIR"
        return 1
    fi
    
    # Construir la imagen Docker
    echo -e "${GREEN}Construyendo imagen Docker para $service...${NC}"
    if docker build -t "$service:latest" .; then
        echo -e "${GREEN}Imagen Docker de $service construida correctamente${NC}"
    else
        echo -e "${RED}Error al construir la imagen Docker de $service${NC}"
        cd "$BASE_DIR"
        return 1
    fi
    
    # Volver al directorio base
    cd "$BASE_DIR"
    return 0
}

# Iterar sobre todos los servicios
for service in "${SERVICES[@]}"; do
    if build_service "$service"; then
        echo -e "${GREEN}✓ $service completado${NC}"
    else
        echo -e "${RED}✗ $service falló${NC}"
    fi
done

# ...existing code...

echo -e "\n${GREEN}==================================================${NC}"
echo -e "${GREEN}Construcción de todos los servicios completada${NC}"
echo -e "${GREEN}==================================================${NC}"

# Volver al directorio donde está el docker-compose.yml
cd "$CURRENT_DIR"

# Levantar los contenedores con docker-compose
echo -e "${YELLOW}Levantando todos los contenedores con docker-compose...${NC}"
docker-compose up -d

echo -e "${GREEN}Todos los contenedores están en ejecución.${NC}"
