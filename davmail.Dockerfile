FROM docker.io/ubuntu:latest

RUN apt-get update && apt-get install -y davmail

# Expects the config file to be mounted as a volume
CMD davmail -c /davmail.properties
