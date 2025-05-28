# Usa una imagen base liviana con Python 3.9 (compatible con dependencias viejas)
FROM python:3.9-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia todo el contenido del proyecto al contenedor
COPY . .

# Instala dependencias del sistema necesarias para compilar algunas librerías de Python
RUN apt-get update && apt-get install -y gcc libffi-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Actualiza pip a una versión compatible con proyectos legacy
RUN pip install --upgrade pip==23.3.1

# Instala dependencias del proyecto
RUN pip install -r requirements.txt && \
    pip install -r requirements_dev.txt && \
    pip install -e .

# Copia automáticamente config_sample.yml a config.yml si aún no existe
RUN [ -f detector_aedes/config_sample.yml ] && \
    cp detector_aedes/config_sample.yml detector_aedes/config.yml || true

# Ejecuta el script principal del proyecto
CMD ["python3", "main.py"]
