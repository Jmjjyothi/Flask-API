# Flask-API
HTTP API Service for serving messages.


**HTTP API Service (Flask):**
Represents the HTTP API service implemented in Python using Flask.
Handles incoming HTTP requests and sends responses.
Exposes endpoints for /get/messages/<account_id>, /create, and /search.


**Python Application:**
The core application logic written in Python.
Handles business logic, request parsing, and response generation.
Interacts with the SQLite database to store and retrieve messages.


**SQLite Database:**
A lightweight and embedded database used to persist message data.
Stores message records with fields such as account_id, message_id, sender_number, and receiver_number.



# FlaskAPI Project

Welcome to the Flask API Service project! This project is a simple HTTP API service for serving messages, implemented in Python using Flask, with SQLite as the database. It includes endpoints for retrieving messages based on account ID, creating messages, and searching messages using various filters. It includes Dockerfiles, Kubernetes files, and a Jenkins pipeline for CI/CD.


## Table of Contents

- [Setup and Development](#setup-and-development)
  - [Prerequisites](#prerequisites)
  - [Local Development](#local-development)
- [Docker Deployment](#docker-deployment)
- [Kubernetes Deployment](#kubernetes-deployment)
- [Jenkins CI/CD Pipeline](#jenkins-cicd-pipeline)


## Setup and Development

### Prerequisites

Ensure you have the following installed:

- Python (3.8 or higher)
- Docker
- Kubernetes (minikube for local testing)
- Jenkins
- Terraform

### Local Development

1. **Clone the repository:**

    ```bash
    git clone https://github.com/jmjjyothi/Flask-API.git
    cd FlaskAPI
    ```

2. **Install dependencies:**

    ```bash
    pip install -r requirements.txt
    ```

3. **Run the Flask application:**

    ```bash
    python app.py
    ```

    The API will be accessible at http://localhost:5000.

## Docker Deployment

Build and run the Docker container:

```bash
docker build -t flask-api .
docker run -p 5000:5000 flask-api
```


## Kubernetes Deployment
Set up a Kubernetes cluster:

Set up a Kubernetes cluster using minikube for local testing or on a cloud provider.

Apply the Kubernetes deployment files:

```bash
kubectl apply -f k8s/
```


**Access the API:**
Access the API service using the assigned LoadBalancer IP.


**Terraform**
Deploy Kubernetes cluster using Terraform:

```bash
cd terraform/
terraform init
terraform apply
```

**Jenkins CI/CD Pipeline**
Set up Jenkins:

Set up Jenkins with the required plugins.

Create a new Jenkins pipeline job:

Create a new Jenkins pipeline job and configure it to point to the Git repository.

Run the pipeline:

Run the pipeline to trigger CI/CD.

****API Endpoints****

**GET /get/messages/<account_id>**
Returns all messages with sender and receiver details for the provided account ID.


**POST /create**
Creates a new message. Requires JSON payload with account_id, sender_number, and receiver_number.


**GET /search**
Search for messages using filters:

/search?message_id=1,2:   Returns messages with the given message IDs.

/search?sender_number=123:   Returns messages with the given sender number.

/search?receiver_number=456:   Returns messages with the given receiver number.


