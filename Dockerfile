# Use an official Python image as the base
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install mkdocs and any necessary plugins
RUN pip install --no-cache-dir poetry

COPY pyproject.toml poetry.lock /app/

RUN poetry config virtualenvs.create false && \
    poetry install --no-root

# Copy the documentation files into the container
COPY mkdocs.yml /app/
COPY Enscribe/ /app/Enscribe/
COPY Handwriting-Server /app/Handwriting-Server/
COPY lambda-kernculus /app/lambda-kernculus/
COPY docs/ /app/docs/

CMD ["poetry", "run", "mkdocs", "serve", "-a", "0.0.0.0:8000"]