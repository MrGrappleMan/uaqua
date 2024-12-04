ARG SOURCE_IMAGE="base"
ARG BASE_IMAGE="base"
ARG IMAGE="base"
ARG TAG_VERSION="stable-daily"
ARG SOURCE_SUFFIX="-main"
ARG SOURCE_TAG="latest"

# Not sure why I need these above tags since I pre mentioned the parameters in the link but ok..

FROM scratch AS ctx
COPY / /

FROM ghcr.io/ublue-os/base-main:latest

RUN --mount=type=bind,from=ctx,src=/,dst=/ctx \
    mkdir -p /var/lib/alternatives && \
    /ctx/build.sh && \
    mv /var/lib/alternatives /staged-alternatives && \
    ostree container commit && \
    mkdir -p /var/lib && mv /staged-alternatives /var/lib/alternatives && \
    mkdir -p /var/tmp && \
    chmod -R 1777 /var/tmp
