FROM docker.io/ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/bin:/root/go/bin:$PATH"

RUN apt-get update && apt-get install -y \
    arduino arduino-builder clangd curl golang

RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
RUN go install github.com/arduino/arduino-language-server@latest

RUN arduino-cli config init

# Local Variables:
# dockerfile-image-name: ghcr.io/lrustand/arduino
# End:
