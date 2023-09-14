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
EXPOSE 80
EXPOSE 8080

# Set the environment variable for Flask to run in production mode
ENV FLASK_ENV=production

# Run the command to start the Flask app
# CMD ["uvicorn", "src.api:app", "--host", "0.0.0.0", "port", "5000", "--reload"]
# CMD ["uvicorn", "src.api:app", "--host", "0.0.0.0", "--reload"]
CMD ["uvicorn", "src.api:app", "--host", "127.0.0.1", "--port", "8080"]