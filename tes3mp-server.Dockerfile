FROM docker.io/debian:latest

RUN apt-get update && apt-get install -y wget libluajit-5.1-2

RUN wget https://github.com/TES3MP/TES3MP/releases/download/tes3mp-0.8.1/tes3mp-server-GNU+Linux-x86_64-release-0.8.1-68954091c5-6da3fdea59.tar.gz

RUN tar xzvf tes3mp-server-GNU+Linux-x86_64-release-0.8.1-68954091c5-6da3fdea59.tar.gz

WORKDIR /TES3MP-server

CMD ./tes3mp-server
