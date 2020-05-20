FROM alpine:3.11.6 AS base

RUN apk add --update-cache \
    unzip

# Download and install TShock
ADD https://github.com/Pryaxis/TShock/releases/download/v4.4.0-pre4/TShock_4.4.0_226_Pre4v2_Terraria1.4.0.2.zip /
RUN unzip TShock_4.4.0_226_Pre4v2_Terraria1.4.0.2.zip -d /tshock && \
    rm TShock_4.4.0_226_Pre4v2_Terraria1.4.0.2.zip && \
    chmod +x /tshock/TerrariaServer.exe

FROM mono:6.8.0.96

LABEL maintainer="satsuper@users.noreply.github.com"

# documenting ports
EXPOSE 7777

ENV WORLDPATH=/world
ENV CONFIGPATH=/world
ENV LOGPATH=/tshock/logs

# copy in bootstrap
COPY bootstrap.sh /tshock/bootstrap.sh

# copy game files
COPY --from=base /tshock /tshock


RUN mkdir /world && \
    mkdir /plugins && \
    mkdir -p /tshock/logs && \
    chmod +x /tshock/bootstrap.sh

# Allow for external data
VOLUME ["/world", "/tshock/logs", "/tshock/ServerPlugins"]

# Set working directory to server
WORKDIR /tshock

# run the bootstrap
ENTRYPOINT [ "/bin/sh", "bootstrap.sh" ]
