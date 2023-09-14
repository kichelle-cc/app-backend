# Cloud Build CI/CD Pipeline Demo

This repository is a template for a generic Python app which supports production level CI/CD. 
The aim is to act as a partially blank canvas for new POCs and assets, assuring they are fit for purpose and removing some of the legwork from the initial setup.

## About the Repo

The repo is split into simple components:

1. src/ Where the source Python code for the product lives
2. src/tests/ Unit tests for the source code
3. requirements.txt Python dependencies for source code
4. gitignore Standard Python files to be ignored
5. Dockerfile Contains all instructions to build an image of the app
6. cloudbuild.yaml Contains instructions for CI/CD using GCP CloudBuild

Components 1 through 5 should be familiar, so we will explain the CloudBuild pipeline in detail.

## CloudBuild 

- **In order to run the build automatically on a new repo you will need to connect it to CloudBuild. This can be done using command line tools, or alternatively using the GUI for Cloud Source Repositories [here](https://source.cloud.google.com/)**
- Select add repository, then navigate to cloud build and create a trigger with the mirrored repository, deciding what condition it needs to be ran on, e.g. on merges to main.
- Navigate to Edit trigger > Substitution variables. Here we can create user defined variables in the cloudbuild.yaml file to allow us to minimise typos etc. We define two:

`_ARTIFACT_REG_REPO_NAME` and `_REPO_NAME`.

After connecting, we can break down the 10 steps which the build contains.

### Steps 1 - 3: Install Dependencies
- these stages upgrade pip, install the packages listed in the `requirements.txt` file, and finally install the packages used for testing the code
- it's important to ensure the `requirements.txt` in your project is up to date to ensure the pipeline has all relevant packages
- this can be ensured by using virtual environments on your local machine or building and running a Docker image for testing

### Steps 4 - 6: Testing
- these stages ensure the code is written and formatted correctly 
- Pytest ensures all unit tests pass succesfully
- Flake8 checks code is formatted to PEP8 standards, with max line length 100  
- LicenseCheck outputs the licenses used by dependencies and check if these are compatible with the defined project license

### Steps 7 - 9: Containerisation
- Next we can build, scan and push our containerised app.
- **For this part to work we need to create a repository in Artifact Registry to store the images. Use the same name you defined in the substitution variables section earlier**.
- First GCR Docker builds an image 
- Then we use Trivy to scan the built image, looking for vulnerabilities
- Lastly, if successful, we push the image to the Artifact Registry repository using the commit name

### Step 10 Deployment: 
- The final step is commented out as we usually don't need to deploy
- This simply deploys to cloud run in the specified region. **You need to make sure the repo name doesn't have any underscores in it**.

## How to run the Example API For Cloud Build CI/CD

This app used for testing is a simple Flask app that displays the current time as an API. It also includes unit tests using pytest, a requirements.txt file, and a Dockerfile for containerization.

## Getting Started

To get started with this project, you'll need to have Python>3.9 and Docker installed on your machine.

1. Clone the repository to your local machine:

```
git clone git@bitbucket.org:dra-engineering/time_app.git
```

2. Navigate to the project directory:

```
cd time_app
```

## Running the App
3. Create a virtual environment called venv:

```
python3 -m venv venv
```

4. Install the required packages using pip:

```
pip install -r requirements.txt
```

To run the Flask app locally, you can use the following command:

```
python src/api.py
```

This will start the app on `http://localhost:5000/time`. You can visit this URL in your web browser to see the current time API in action.

## Running the Tests

To run the unit tests for the Flask app, you can use the following command:

```
pytest
```

This will run all the tests in the `tests/` directory and display the results in your terminal.

## Building the Docker Image

To build a Docker image for the Flask app, you can use the following command:

```
docker build -t time-app .
```

This will build a Docker image with the name `time-app`. You can then run the image using the following command:

```
docker run -p 5000:5000 time-app
```

This will start the app inside a Docker container and map port 5000 in the container to port 5000 on your local machine. You can visit `http://localhost:5000/time` in your web browser to see the current time API in action.