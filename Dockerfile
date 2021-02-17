# our base image
FROM ubuntu:latest

# Set timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install packages
RUN apt-get update
RUN apt-get install apt-utils -y
RUN apt-get install cron git python3 curl -y
RUN apt-get install openjdk-11-jdk-headless maven -y
RUN apt-get install nginx -y

# Write dummy git config
RUN git config --global user.email "mail@example.com"
RUN git config --global user.name "John Doe"


# Add shell scripts and grant execution rights
COPY build.sh /app/build.sh
RUN chmod +x /app/build.sh

# Things for building
RUN mkdir app/build
COPY config.ini /app/config.ini

# Nginx configuration
COPY nginx.config /etc/nginx/sites-available/paper_build
RUN ln -s /etc/nginx/sites-available/paper_build /etc/nginx/sites-enabled/
# expose port set in nginx config
EXPOSE 81

# Add crontab file in the cron directory
COPY crontab /var/spool/cron/crontabs/root
# Give execution rights on the cron job
RUN chmod 0644 /var/spool/cron/crontabs/root

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

ENTRYPOINT service nginx restart && service cron restart && bash