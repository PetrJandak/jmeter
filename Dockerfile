# JMeter base image
FROM openjdk:8-jre-alpine

# Set JMeter version
ARG JMETER_VERSION="5.4.1"
ARG PLUGINS_PATH="/jmeter/lib/ext"
ENV JAVA_OPTS="-Xms512m -Xmx2048m"


# Copy entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# Install wget and unzip
RUN apk add --update wget unzip

# Download and install JMeter
RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz && \
    tar -xzf apache-jmeter-${JMETER_VERSION}.tgz && \
    rm apache-jmeter-${JMETER_VERSION}.tgz && \
    mv apache-jmeter-${JMETER_VERSION} /jmeter

# Set JMeter home
ENV JMETER_HOME /jmeter

# Add JMeter bin to PATH
ENV PATH $JMETER_HOME/bin:$PATH

# Install JMeter ExtrasLibs plugin
RUN wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-1.4.0.zip && \
    unzip -o JMeterPlugins-ExtrasLibs-1.4.0.zip -d $PLUGINS_PATH

# Set the working directory to /jmeter
WORKDIR /jmeter

# Expose the required ports for JMeter
EXPOSE 1099 50000 6000

# Set the default command for the image
ENTRYPOINT ["entrypoint.sh"]
