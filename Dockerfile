# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory to /app
WORKDIR '/app'

# Copy the requirements file into the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Expose port 5000 for the Flask app to run locally
# OR expose port 8080 for the gcloud app to listen on 

# Set the environment variable for Flask to run in production mode
# ENV FLASK_ENV=production

# Run the command to start the Flask app
# CMD ["uvicorn", "src.api:app", "--host", "0.0.0.0", "port", "5000", "--reload"]
# CMD ["uvicorn", "src.api:app", "--host", "0.0.0.0", "--reload"]
EXPOSE 8080
CMD ["uvicorn", "src.api:app", "--host", "0.0.0.0", "--port", "8080"]

# FROM python:3.9-slim-buster
# # FROM python:3.7-slim
# WORKDIR /app
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
# RUN pip install pipenv
# RUN pipenv install --deploy --system
# COPY . .
# EXPOSE 80
# CMD exec gunicorn --bind :80 --workers 1 --worker-class uvicorn.workers.UvicornWorker  --threads 8 app.main:app
