# Self-Hosting Instructions - Docker

To self-host Enscribe, follow these steps:

1. **Docker-Compose file**  

    All of our microservices are available as docker images, and can be run using docker-compose.
    ```yaml
    services:
        mariadb:
            container_name: mariadb
            image: mariadb:latest
            restart: always
            environment:
            MYSQL_DATABASE: enscribedb
            MYSQL_USER: enscribe
            MYSQL_PASSWORD: your_password_here
            MYSQL_ROOT_PASSWORD: your_root_password_here
            volumes:
            - mariadb_data:/var/lib/mysql
            networks:
            - enscribe_default
        api:
            image: ghcr.io/a-team-name/enscribe:latest
            restart: unless-stopped
            env_file: ".env"
            ports:
            - "5000:5000"
            networks:
            - enscribe_default
            depends_on:
            - mariadb
            - kernel
            - hwserver

        kernel:
            container_name: kernel
            image: ghcr.io/a-team-name/lambda-kernculus:latest
            restart: unless-stopped
            volumes:
            - ./work:/home/jovyan/work
            networks:
            - enscribe_default
            command: "start-notebook.sh --ServerApp.disable_check_xsrf=True --NotebookApp.token="

        hwserver:
            container_name: hwserver
            image: ghcr.io/a-team-name/handwriting-server:latest
            env_file: ".env"
            networks:
            - enscribe_default

        volumes:
            mariadb_data:

        networks:
            enscribe_default:
                external: True
    ```

1. **Environment file** 

    Some environment variables are required to run the application and should be configured in a `.env` file. These include:

    - DJANGO_ENV - The environment the application is running in. This should be set to "production" for production environments.
    - SECRET_KEY - A randomly generated key for django. This should be kept secret and not shared with anyone.
    - MYSQL_NAME - The name for the database to use
    - MYSQL_USER - The user to use for the database
    - MYSQL_PASSWORD - The password for the database user
    - MYSQL_ROOT_PASSWORD - The password for the root user
    - MYSQL_HOST - The host for the database. This should be set to "mariadb" for the docker-compose file above.
    - MYSQL_PORT - The port for the database. This should be set to "3306" for the docker-compose file above.
    - ALLOWED_HOSTS - The allowed hosts for the application. This should be set to the domain name of the application. Can support multiple domains separated by commas.
    - HANDWRITING_URL - The URL for the handwriting server. This should be set to "hwserver" for the docker-compose file above.
    - HANDWRITING_PORT - The port for the handwriting server. This should be set to "5000" for the docker-compose file above.
    - FLASK_ENV - The environment the Handwriting server is running in. This should be set to "production" for production environments.
    - JUPYTER_URL - The URL for the jupyter server. This should be set to "kernel" for the docker-compose file above.
    - JUPYTER_PORT - The port for the jupyter server. This should be set to "8888" for the docker-compose file above.

    A working example .env file you could copy is:
    ```env
    DJANGO_ENV=production
    SECRET_KEY=your_secret_key
    MYSQL_NAME=enscribedb
    MYSQL_USER=enscribe
    MYSQL_PASSWORD=your_password_here
    MYSQL_ROOT_PASSWORD=your_root_password_here
    MYSQL_HOST=mariadb
    MYSQL_PORT=3306
    ALLOWED_HOSTS=*
    HANDWRITING_URL=hwserver
    HANDWRITING_PORT=5000
    FLASK_ENV=production
    JUPYTER_URL=kernel
    JUPYTER_PORT=8888
    ```




2. **Run Docker-Compose**  

    Ensure you have Docker and Docker Compose installed. Then, run:  
    ```bash
    docker-compose up --build
    ```

3. **Access Enscribe**  
    Once the application is running, you can access it at `http://localhost:8000`.