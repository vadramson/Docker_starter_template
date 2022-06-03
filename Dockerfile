# syntax=docker/dockerfile:1

# Base image
FROM python:3.10.4-slim-buster

# Just an abitrary name for the container's  working directory
WORKDIR /app 

# Use root user to install and copy all the necessary packages
USER root
RUN apt-get update -y && apt-get install -y python3-dev python3-pip build-essential  && apt-get install gcc -y && apt-get install sudo -y && apt-get clean


RUN apt-get update && apt-get -y install sudo
      
#RUN adduser --disabled-password --gecos '' airflow

#RUN useradd --disabled-password --gecos '' airflow

# Create new user airflow
RUN useradd -ms /bin/bash airflow

# Add new group docker
RUN groupadd docker

# Add the created airflow user to the docker group
RUN usermod -a -G docker airflow
RUN usermod -aG docker airflow

# ** --  Start add python dependencies   -- **

# The first COPY command below copy's requirements.txt file to the container's parent directory call /app
# The second COPY command below copy's all files and directory in the local folder to the container's parent directory call /app

#COPY requirements.txt .  

#RUN pip install -r requirements.txt

COPY . .  

# Install all necessary packages
RUN pip3 install pandas
RUN pip3 install -r https://raw.githubusercontent.com/snowflakedb/snowflake-connector-python/v2.7.6/tested_requirements/requirements_310.reqs
RUN pip3 install snowflake-connector-python
RUN pip3 install "snowflake-connector-python[secure-local-storage,pandas]"
RUN pip install lxml html5lib beautifulsoup4



# ** --  End add python dependencies   -- **


# Use airflow user to run docker container
USER airflow

# DONT DO THIS
#RUN chmod 777 /var/run/docker.sock


# Container Entry point to execute the container
CMD [ "python", "request_launch.py"]



