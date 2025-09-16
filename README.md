# TempusUGR - Orquestación con Docker Compose

Este repositorio contiene la configuración de `docker-compose.yml` para desplegar la infraestructura completa del backend del proyecto **TempusUGR**.

El propósito es simplificar la puesta en marcha de todos los microservicios y sus dependencias (bases de datos, bus de mensajes) en un entorno de desarrollo o producción, asegurando que todos los componentes se inicien en el orden correcto y se conecten a través de una red compartida.

---

## 🏗️ Arquitectura Desplegada

Este archivo `docker-compose` levanta una arquitectura de microservicios contenerizada. Define, configura y enlaza todos los servicios necesarios para que el backend de TempusUGR funcione correctamente.

Los servicios se comunican entre sí a través de una red Docker personalizada (`calendarugr-net`), utilizando los nombres de servicio como hostnames.

---

## 🛠️ Servicios Gestionados

La configuración orquesta los siguientes contenedores:

### Microservicios de la Aplicación
* **`api-gateway`**: Punto de entrada único que enruta las peticiones a los demás servicios.
* **`eureka-service`**: Servidor de descubrimiento para el registro y localización de los microservicios.
* **`user-service`**: Gestiona los datos y la lógica de los usuarios.
* **`auth-service`**: Procesa la autenticación y la generación de tokens JWT.
* **`schedule-consumer-service`**: Encargado de obtener y almacenar los horarios académicos.
* **`academic-subscription-service`**: Gestiona las suscripciones y calendarios personalizados.
* **`mail-service`**: Procesa el envío de correos electrónicos de forma asíncrona.

### Servicios de Soporte (Backing Services)
* **`mysql-db`**: Base de datos relacional para `user-service` y `schedule-consumer-service`.
* **`mongo-db`**: Base de datos NoSQL para `academic-subscription-service`.
* **`rabbitmq`**: Bus de mensajes para la comunicación asíncrona.

---

## 🚀 Puesta en Marcha

### **Prerrequisitos**

* [Docker](https://www.docker.com/get-started/)
* [Docker Compose](https://docs.docker.com/compose/install/)

### **Configuración**

Este proyecto utiliza un archivo `.env` para gestionar las variables de entorno y los secretos (contraseñas, claves, etc.).

1.  **Crea un archivo `.env`** en la raíz del repositorio.

### **Ejecución**

1.  **Clona el repositorio:**
    ```bash
    git clone [https://github.com/TempusUGR/docker-compose.git](https://github.com/TempusUGR/docker-compose.git)
    cd docker-compose
    ```
2.  **Levanta todos los servicios:**
    Ejecuta el siguiente comando en la raíz del proyecto. Docker Compose descargará las imágenes necesarias, creará los contenedores y los iniciará en segundo plano (`-d`).
    ```bash
    docker-compose up -d
    ```
3.  **Verificar el estado:**
    Para comprobar que todos los contenedores están en ejecución, usa:
    ```bash
    docker-compose ps
    ```
4.  **Ver los logs:**
    Para ver los logs de todos los servicios en tiempo real:
    ```bash
    docker-compose logs -f
    ```
    Para ver los logs de un servicio específico (por ejemplo, `api-gateway`):
    ```bash
    docker-compose logs -f api-gateway
    ```
5.  **Detener los servicios:**
    Para detener y eliminar todos los contenedores definidos en la configuración, ejecuta:
    ```bash
    docker-compose down
    ```
    Si quieres eliminar también los volúmenes de datos (¡CUIDADO: esto borrará los datos de las bases de datos!), usa:
    ```bash
    docker-compose down -v
    ```
