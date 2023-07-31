# JMeter Docker Image

This repository contains a Dockerfile for creating a Docker image that runs Apache JMeter.

## Overview

The Dockerfile in this repository builds a Docker image based on the `adoptopenjdk:8-jre-hotspot` image. Apache JMeter and the JMeter plugins manager are installed into the image, along with additional JMeter plugins.

The JMeter server is configured to listen on ports 1099, 50000 and 60000, which are exposed by the Dockerfile.

An `entrypoint.sh` script is included in the image, which is used as the container's entrypoint. This script runs JMeter with any arguments passed to the `docker run` command.

## Dockerfile Details

The Dockerfile performs the following steps:

1. `FROM adoptopenjdk:8-jre-hotspot` - The base image is the `adoptopenjdk:8-jre-hotspot` image, which includes the Java Runtime Environment (JRE) needed to run JMeter.

2. `ARG JMETER_VERSION="5.4.3"` - The version of JMeter to install is configured with a build argument.

3. `ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}` and `ENV PATH $PATH:$JMETER_HOME/bin` - Environment variables are set for the JMeter installation directory and to add the JMeter `bin` directory to the `PATH`.

4. JMeter is downloaded and installed using `wget` and `tar`.

5. The JMeter plugins manager is downloaded and installed.

6. The JMeter extras and other plugins are downloaded and installed.

7. `EXPOSE 1099 50000 60000` - Ports 1099, 50000 and 60000 are exposed for the JMeter server.

8. `COPY entrypoint.sh /entrypoint.sh` and `RUN chmod +x /entrypoint.sh` - The `entrypoint.sh` script is copied into the image and made executable.

9. `ENTRYPOINT ["/entrypoint.sh"]` - The `entrypoint.sh` script is set as the entrypoint for the container.

## Usage

To use this image, you can pull it from the Docker registry where it is hosted, and run it with `docker run`. 

When running the container, you will likely want to map volumes for your test files and results, like so:

```bash
docker run -v /path/to/tests:/jmeter/tests -v /path/to/results:/jmeter/results your-jmeter-image -n -t /jmeter/tests/your-test.jmx -l /jmeter/results/your-results.jtl
