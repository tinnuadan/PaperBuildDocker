# our base image
FROM ubuntu:latest

# Set timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install packages
RUN apt-get update
RUN apt-get install apt-utils -y
RUN apt-get install git python3 curl -y
RUN apt-get install openjdk-11-jdk-headless maven -y

# Write dummy git config
RUN git config --global user.email "mail@example.com"
RUN git config --global user.name "John Doe"


# Add shell scripts and grant execution rights
COPY build.sh /app/build.sh
RUN chmod +x /app/build.sh

# Things for building
RUN mkdir app/build
COPY config.ini /app/config.ini

CMD ["app/build.sh"]

# to get the compiled files do:
# docker cp <containerId>:/app/build/ /host/target_path/