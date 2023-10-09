This example GitHub repo demonstrates how to create a Shiny app Docker container image, within the OHDSI organization on Docker Hub, which is compatible with the ShinyProxy software used by the OHDSI results.ohdsi.org website.

# Develop and test the Docker Image locally

## Step 1
Create your own GitHub repo and develop and test your Shiny app on your local computer.

## Step 2
Copy the following files from this repo to your GitHub repo:
```
Dockerfile
docker-compose.yml
```

## Step 3
Update the Dockerfile based on the OS, R, Python etc. dependencies for your Shiny application.

## Step 4
Update the docker-compose.yml file to use your Docker service name, Shiny app name.and Docker container image name instead of the example "ohdsipredictiontutorial", "ohdsi/ohdsipredictiontutorial" and "OhdsPredictionTutorial". Note these values are case-sensitive. The docker image name must be in all lower-case. If you are using a data file then update the volumes section with the full file path name on your local computer.

## Step 5
Develop and debug the Docker image on your local computer which has Docker installed. The docker-compose.yml file can be used for this.
Use the standard command to build the Docker image on your local computer:
```
docker compose build
```

Use the standard command to run the Docker image on your local computer:
```
docker compose up -d
```

# Upload your data file to the results.ohdsi.org data server
This is optional. It is not required if the data is stored in a new schema in the OHDSI Shiny database (preferred). See an example of the data file path to use in your R code, in the server.R file in this GitHub repo.

## Create a GitHub (release) action in your repo to build and push the Docker image to Docker Hub
Use the below example GitHub Action yml in the below file in this repo as a template to create your GitHub repo gitHub action:
```
.github/workflows/main.yml
```

**IMPORTANT: You must replace the environent variables in the main.yml file to use your Shiny app app name, docker image name, maintainer and author email addresses. No other changes are needed**

## Create a release for your shiny app in your GitHub repo
This will trigger your GitHub action to run which will build the Docker image and push it to Docker Hub. Review the GitHub actions log to ensure it completed successfully.

## Deploy your Shiny app Docker image as a new Shiny app in the results.ohdsi.org website
See the instructions in the OHDSI ShinyProxyDeploy GitHub repo here:
https://github.com/OHDSI/ShinyProxyDeploy

## Notes
* You can upload newer versions of your data file to the OHDSI file server without having to rebuild and re-deploy the Shiny app Docker image.
* You can update the data in the OHDSI Shiny app Database without having to rebuild and re-deploy the Shiny app Docker image
* Any Shiny app Docker image can be deployed to the results.ohdsi.org as long as it is compatible with the ShinyProxy software and is publicly available. This GitHub repo just shows an example of how to achieve this within the OHDSI organization within Docker Hub.
