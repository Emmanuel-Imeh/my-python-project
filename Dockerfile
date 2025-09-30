# Base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy files
COPY . /app

# Install FastAPI and Uvicorn
RUN pip install fastapi uvicorn

# Expose port
EXPOSE 8000

# Run the FastAPI app
CMD ["python", "app.py"]

