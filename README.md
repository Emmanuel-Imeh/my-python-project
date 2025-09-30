# 🐳 My Python App (Dockerized)

This project demonstrates how to containerize a simple Python application with Docker, push it to GitHub, and automate multi-platform builds to Docker Hub using GitHub Actions.

## ⚡️ Prerequisites

- Docker Desktop installed on your machine

- Git installed

- A GitHub account

- A Docker Hub account. 

## 🚀 Step 1: Install Docker Desktop

Download and install Docker Desktop for your OS:

Mac

Windows

Linux

Verify installation:

docker --version
docker compose version

## 🚀 Step 2: Create a Simple Python Project
mkdir my-python-app
cd my-python-app


app.py

print("Hello from my Dockerized Python app! 🚀")


Dockerfile
```yml
# Use official Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy application code
COPY app.py .

# Command to run the app
CMD ["python", "app.py"]
```

Test locally:

docker build -t my-python-app .
docker run --rm my-python-app

## 🚀 Step 3: Push Code to GitHub

### Initialize Git and commit:

git init
git add .
git commit -m "Initial commit - my-python-app with Dockerfile"


### Create a repo on GitHub (e.g. my-python-app), then link & push:

git branch -M main
git remote add origin git@github.com:YOUR_USERNAME/my-python-app.git
git push -u origin main

## 🚀 Step 4: Set Up Docker Hub Repository

Log in to Docker Hub

Create a new public repo named my-python-app

## 🚀 Step 5: Configure GitHub Actions for Multi-Arch Builds
1. Create a Docker Hub Access Token

Go to Docker Hub → Account Settings → Security → New Access Token

Select Read/Write

Save the token (you’ll only see it once)

2. Add GitHub Secrets

In your GitHub repo → Settings → Secrets and variables → Actions

DOCKERHUB_USERNAME → your Docker Hub username

DOCKERHUB_TOKEN → the access token

3. Create Workflow File

Add .github/workflows/docker-build.yml:

```yml name: Build and Push Docker image

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push (multi-platform)
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          platforms: linux/amd64,linux/arm64
          tags: ${{ secrets.DOCKERHUB_USERNAME }}/my-python-app:latest
```


### Commit & push:

```sh
git add .github/workflows/docker-build.yml

git commit -m "Add GitHub Actions workflow for Docker build"
git push
```

### 🚀 Step 6: Verify Build

Go to GitHub → Actions tab → ensure build succeeded

Check Docker Hub → your image my-python-app:latest is available

## Pull & run on any machine:

```sh
docker run --rm YOUR_USERNAME/my-python-app:latest
```


Docker will automatically pull the right image for the host (Intel/AMD or Apple Silicon).

🎉 Done!

You now have:  
✅ A Python app.  
✅ Containerized with Docker.  
✅ Hosted on GitHub.  
✅ Automated builds to Docker Hub.  
✅ Multi-arch support (works on Intel & ARM)   



# 🚀 FastAPI on Kubernetes

This project demonstrates deploying a simple FastAPI app inside a local Kubernetes cluster (via Docker Desktop).

## 📂 Project Structure
```
.
├── app.py             # FastAPI application
├── Dockerfile         # Container definition
├── deployment.yaml    # Kubernetes Deployment
└── service.yaml       # Kubernetes Service  
```

# 🛠 Requirements

- Docker Desktop
 with Kubernetes enabled

- kubectl CLI installed

- Python 3.10+

## 🔧 Setup & Run
1. Clone and Build
git clone <your-repo>
cd <your-repo>
docker build -t myfastapi-app:latest .

2. Apply Kubernetes Manifests
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

3. Port Forward the Service
kubectl port-forward svc/myapp-service 8000:8000

4. Access the App

API Root: http://localhost:8000/

API Docs: http://localhost:8000/docs

## ⚡️ Useful Commands
Check Resources  
```sh
kubectl get pods  
kubectl get svc 
``` 

##Port forward locally

Run:

```sh
kubectl port-forward svc/myapp-service 8000:8000
```
This binds your local http://localhost:8000/
 directly to the FastAPI app running inside the cluster 🎉.

Scale Deployment
```sh
kubectl scale deployment myapp-deployment --replicas=3
```

Update Image (Rolling Update)
```sh
kubectl set image deployment/myapp-deployment myapp=<dockerhub-user>/<image>:v2
```

✅ Output Example
{"message": "Updated build!"}


