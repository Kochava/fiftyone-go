from --platform=amd64 gcc:latest as stage1


WORKDIR /usr/local/
RUN apt update && apt install -y git curl gnupg apt-transport-https cmake gcc

RUN curl https://packages.microsoft.com/keys/microsoft.asc  | gpg --dearmor \
 | tee /usr/share/keyrings/powershell.gpg >/dev/null

RUN echo "deb [arch=amd64,armhf,arm64 signed-by=/usr/share/keyrings/powershell.gpg] \
https://packages.microsoft.com/debian/11/prod bullseye main" \
    | tee /etc/apt/sources.list.d/powershell.list
RUN apt update && apt install -y powershell

RUN git clone https://github.com/51Degrees/device-detection-go.git

WORKDIR /usr/local/device-detection-go
RUN git submodule update --init --recursive

WORKDIR /usr/local/device-detection-go/dd/device-detection-cxx/
RUN mkdir build
WORKDIR /usr/local/device-detection-go/dd/device-detection-cxx/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release
RUN cmake --build .

WORKDIR /usr/local/
