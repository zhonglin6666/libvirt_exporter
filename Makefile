GOFILES_NOVENDOR=$(shell find . -type f -name '*.go' -not -path "./vendor/*")
GO_VERSION=1.15

REGISTRY=exporter
NAME=libvirt_exporter
DEV_TAG=dev
RELEASE_TAG=$(shell cat VERSION)
COMMIT=git-$(shell git rev-parse HEAD)
DATE=$(shell date +"%Y-%m-%d_%H:%M:%S")
HOST_DIR=${GOPATH}/src/libvirt_exporter

GOLDFLAGS="-w -s -X github.com/kubeovn/kube-ovn/versions.COMMIT=${COMMIT} -X github.com/kubeovn/kube-ovn/versions.VERSION=${RELEASE_TAG} -X github.com/kubeovn/kube-ovn/versions.BUILDDATE=${DATE}"

# ARCH could be amd64,arm64
ARCH=amd64
# RPM_ARCH could be x86_64,aarch64
RPM_ARCH=x86_64

.PHONY: build-go

build-go:
	docker build -t ${REGISTRY}/libvirt-exporter:${DEV_TAG} .
	docker run -it --rm --name build -v ${HOST_DIR}:/go/src/libvirt_exporter ${REGISTRY}/libvirt-exporter:${DEV_TAG} ${NAME}
