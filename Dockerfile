# We are using ubuntu as the base image

FROM ubuntu

# Update & Upgrade ubuntu

RUN apt update
RUN apt upgrade -y

# Install some dependencies

RUN apt install git -y
RUN git --version
RUN apt install make -y
RUN make --version
RUN apt install vim -y
RUN vim --version
RUN apt install curl -y
RUN curl --version
RUN apt install gcc -y
RUN gcc --version

# Use curl to download go

RUN curl -OL "https://go.dev/dl/go1.20.7.linux-amd64.tar.gz"

# Unzip go & add it to the path

RUN tar -C /usr/local/ -xzf "go1.20.7.linux-amd64.tar.gz"
ENV PATH="{$PATH}:/usr/local/go/bin"

# Check go version

RUN go version

# Download geth source code from the official github repository

RUN git clone "https://github.com/ethereum/go-ethereum.git"

# Go to the folder and run the makefile

WORKDIR "go-ethereum"
RUN make geth
RUN /go-ethereum/build/bin/geth --version

# Execute geth whenever the container is launched

CMD ["/go-ethereum/build/bin/geth"]

