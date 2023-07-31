#!/bin/sh
set -e
sh -c "jmeter $JAVA_OPTS $@"
This will pass the JAVA_OPTS environment variable to the jmeter command when the Docker container is run.