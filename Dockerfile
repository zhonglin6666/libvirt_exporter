# Stage 1: Build libvirt exporter
FROM centos:7

# Install dependencies
RUN yum update -y && \
    yum install -y git gcc g++ make wget libvirt-devel libxml2 && \
    wget https://golang.google.cn/dl/go1.15.10.linux-amd64.tar.gz && \
    tar -xvzf go1.15.10.linux-amd64.tar.gz -C /usr/local && \
    rm -rf go1.15.10.linux-amd64.tar.gz

# Prepare working directory
ENV LIBVIRT_EXPORTER_PATH=/go/src/libvirt_exporter
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $PATH:$GOPATH/bin:$GOROOT/bin
ENV GOPROXY https://goproxy.io
RUN mkdir -p $LIBVIRT_EXPORTER_PATH
WORKDIR $LIBVIRT_EXPORTER_PATH

ADD entry-point.sh ./
ENTRYPOINT ["./entry-point.sh"]
