FROM scratch AS ctx
COPY build_files /
COPY system_files /files

FROM ghcr.io/ublue-os/bluefin-dx-nvidia-open:beta

RUN rm /opt && mkdir /opt

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh
    
RUN bootc container lint
