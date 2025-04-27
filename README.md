# Despliegue de Servicios con Docker Compose

Este repositorio contiene el archivo `docker-compose.yml` necesario para levantar los servicios de la aplicación. Se asume que las imágenes Docker necesarias y los archivos `.jar` de las aplicaciones ya han sido construidos y están disponibles localmente o en un registro de contenedores configurado.

Además, se incluye un script `build_services.sh` para automatizar la generación de las imágenes Docker y la construcción de los archivos `.jar` antes de desplegar los servicios con Docker Compose.

## Prerrequisitos

Antes de comenzar, asegúrate de tener instalado lo siguiente en tu sistema:

* **Docker:** La plataforma de contenedores. Puedes encontrar las instrucciones de instalación en la [documentación oficial de Docker](https://docs.docker.com/engine/install/).
* **Docker Compose:** Una herramienta para definir y ejecutar aplicaciones multi-contenedor Docker. Se instala generalmente junto con Docker Desktop o se puede instalar por separado siguiendo las instrucciones en la [documentación oficial de Docker Compose](https://docs.docker.com/compose/install/).
* **Bash:** El shell utilizado para ejecutar el script `build_services.sh`.

Y de crear el .env con las variables necesarias.

## Despliegue de los Servicios

**Opción 1: Utilizando imágenes y `.jar` pre-construidos**

Si ya tienes las imágenes Docker necesarias construidas y los archivos `.jar` actualizados, puedes desplegar los servicios directamente con Docker Compose:

1.  Clona este repositorio en tu máquina local:
    ```bash
    git clone <URL_DEL_REPOSITORIO>
    cd <nombre_del_repositorio>
    ```

2.  Ejecuta el siguiente comando para levantar todos los servicios definidos en `docker-compose.yml`:
    ```bash
    docker-compose up -d
    ```
    El flag `-d` indica que los contenedores se ejecutarán en segundo plano (detached mode).

3.  Para ver el estado de los contenedores, puedes usar el siguiente comando:
    ```bash
    docker-compose ps
    ```

**Opción 2: Utilizando el script `build_services.sh` (si aplica)**

Si necesitas construir las imágenes Docker y/o generar los archivos `.jar` antes de desplegar los servicios, puedes utilizar el script `build_services.sh`.

1.  Asegúrate de que el script tenga permisos de ejecución:
    ```bash
    chmod +x build_services.sh
    ```

2.  Ejecuta el script:
    ```bash
    ./build_services.sh
    ```
    Este script realizará las tareas necesarias para construir las imágenes y/o los `.jar` según su implementación.

3.  Una vez que el script haya finalizado, puedes desplegar los servicios con Docker Compose como se describe en la **Opción 1**:
    ```bash
    docker-compose up -d
    ```

## Configuración

El archivo `docker-compose.yml` contiene la configuración de los diferentes servicios, incluyendo:

* **Imágenes Docker utilizadas:** Se especifican las imágenes que se utilizarán para cada servicio. Asegúrate de que estas imágenes estén disponibles localmente o que Docker Compose pueda acceder a ellas a través de un registro configurado.
* **Puertos:** Se definen las exposiciones de puertos de los contenedores a la máquina host.
* **Volúmenes:** Se configuran los volúmenes para la persistencia de datos o para compartir archivos entre el host y los contenedores.
* **Variables de entorno:** Se definen las variables de entorno necesarias para la configuración de cada servicio.

Revisa y adapta el archivo `docker-compose.yml` según las necesidades específicas de tu aplicación.

## Detener los Servicios

Para detener todos los servicios en ejecución, ejecuta el siguiente comando en el mismo directorio donde se encuentra el archivo `docker-compose.yml`:

```bash
docker-compose down