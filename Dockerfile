# Base image
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy everything into the container
COPY . /app

# Command to run when container starts
CMD ["python", "app.py"]

