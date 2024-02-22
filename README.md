# Introduction
This project aims to facilitate the training process for database administrators using Jarvis. It involves setting up a Linux environment with Docker and PostgreSQL (psql), creating tables to store host information and usage data, and developing scripts to manage database operations. The primary users of this project are individuals undergoing training to become database administrators. Technologies utilized include bash scripting, Docker, PostgreSQL, and Git.
# Quick Start

./psql_docker.sh

psql -h localhost -U postgres -d host_agent -f ddl.sql

./host_info.sh

./host_usage.sh

crontab -e

# Implemenation
## Setting up Linux Environment
Create a CentOS 7 VM on GCP: Provision a CentOS 7 virtual machine on Google Cloud Platform (GCP) to serve as the host environment.
SSH into the VM: Connect to the CentOS 7 VM using SSH to perform further
setup.
## Install Docker: 
Install Docker on the CentOS 7 VM to facilitate containerization.
Pull PostgreSQL Docker Image: Pull the PostgreSQL Docker image from the Docker Hub repository.
Start PostgreSQL Container: Run a Docker container with PostgreSQL instance.
## Writing Scripts
## Database Modeling
host_info table: Stores information about host hardware such as hostname, CPU number, CPU architecture, CPU model, total memory, and timestamp.
host_usage table: Stores information about host usage such as timestamp, CPU usage, memory usage, disk IO, and disk available.
# Scripts
Shell script description and usage (use markdown code block for script usage)
- psql_docker.sh
- host_info.sh
- host_usage.sh
- crontab
- queries.sql (describe what business problem you are trying to resolve)
# Test
Testing the scripts and results directly on the VM running in GCP
# Deployment
Deployment scripts are running using cron as a cron jobs to collect and fill the dara base
# Improvements
Hardware and Software independency: since the script might fail for some edge cases (if some software are not installed eg: lscpu)
Decentralizing the database: the database for the moment is running locally, it would be a good improvment to decentralize it and expose it outside the local scope
Docker container healthcheck: to make sure that the container keeps running and is recovered if there is any problem
