# Documentation
---
## How to run this ?
#### First run this to get an image form the docker file
```
sudo docker build -t geth -f <path_to_dockerfile>
```
#### Then run this to see all the available docker images on your system
```
sudo docker images
```
#### Then run this command & replace text within <> with the hash value of the image obtained from the table after running the previous command
```
sudo docker run -p 30303:30303 -d <hash_value_next_to_geth_named_image>
```
---
## Docker File code explanation
#### FROM keyword in this line is used for importing ubuntu as the base image
```
FROM ubuntu
```
#### Next I have added two of these RUN commands to update &amp; upgrade the Ubuntu distribution (RUN executes a command while the image is being built using the docker file)
```
RUN apt update
RUN apt upgrade -y
```
#### Then I'm installing some dependencies like gcc, curl, vim, make &amp; git so that one can compile and run the project and also make some open source contributions to it
```
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
```
#### Get the zipped go compiler from the official website using curl
```
RUN curl -OL "https://go.dev/dl/go1.20.7.linux-amd64.tar.gz"
```
#### Unzip the tar archive and set the go executable to the path &  also check the go version
```
RUN tar -C /usr/local/ -xzf "go1.20.7.linux-amd64.tar.gz"
ENV PATH="{$PATH}:/usr/local/go/bin"
RUN go version
```
#### Clone the official geth github repositiory using git
```
RUN git clone "https://github.com/ethereum/go-ethereum.git"
```
#### Go to the cloned directory and run the make file and check the version of the geth build
```
WORKDIR "go-ethereum"
RUN make geth
RUN /go-ethereum/build/bin/geth --version
```

#### Run an ethereum full node, wherever a container is fired using the image created by this file (CMD runs a command when a container is created)
```
CMD ["/go-ethereum/build/bin/geth"]
```