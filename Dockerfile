# our base image
FROM ubuntu:latest

# Set timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Write dummy git config
RUN git config --global user.email "mail@example.com"
RUN git config --global user.name "John Doe"

# Install packages
RUN apt-get update
RUN apt-get install apt-utils -y
RUN apt-get install cron git python3 curl -y
RUN apt-get install openjdk-11-jdk-headless maven -y

# Add crontab file in the cron directory
COPY crontab /etc/cron.d/simple-cron

# Add shell script and grant execution rights
COPY build.sh /app/build.sh
RUN chmod +x /app/build.sh
COPY config.ini /app/config.ini

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/simple-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log