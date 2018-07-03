FROM alpine:3.7
MAINTAINER Sebastien LANGOUREAUX (linuxworkgroup@hotmail.com)

# Application settings
ENV CONFD_PREFIX_KEY="/consul" \
    CONFD_BACKEND="env" \
    CONFD_INTERVAL="60" \
    CONFD_NODES="" \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    LANG="en_US.utf8" \
    APP_HOME="/opt/consul" \
    APP_VERSION="1.2.0" \
    SCHEDULER_VOLUME="/opt/scheduler" \
    USER=consul \
    GROUP=consul \
    UID=10003 \
    GID=10003 \
    CONTAINER_NAME="alpine-consul" \
    CONTAINER_AUHTOR="Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>" \
    CONTAINER_SUPPORT="https://github.com/disaster37/alpine-consul/issues" \
    APP_WEB="https://www.consul.io"

# Install extra package
RUN apk --update add fping curl bash ca-certificates &&\
    rm -rf /var/cache/apk/*

# Install confd
ENV CONFD_VERSION="0.14.0" \
    CONFD_HOME="/opt/confd"
RUN mkdir -p "${CONFD_HOME}/etc/conf.d" "${CONFD_HOME}/etc/templates" "${CONFD_HOME}/log" "${CONFD_HOME}/bin" &&\
    curl -Lo "${CONFD_HOME}/bin/confd" "https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64" &&\
    chmod +x "${CONFD_HOME}/bin/confd"

# Install s6-overlay
RUN curl -sL https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz \
    | tar -zx -C /




# Install Consul software
RUN \
    mkdir -p ${APP_HOME}/bin ${APP_HOME}/conf ${APP_HOME}/bootstrap ${APP_HOME}/data  && \
    curl https://releases.hashicorp.com/consul/${APP_VERSION}/consul_${APP_VERSION}_linux_amd64.zip -o /tmp/consul.zip &&\
    unzip /tmp/consul.zip -d /tmp &&\
    ls -al /tmp/consul &&\
    mv /tmp/consul ${APP_HOME}/bin/ &&\
    rm -rf /tmp/consul* &&\
    addgroup -g ${GID} ${GROUP} && \
    adduser -g "${USER} user" -D -h ${APP_HOME} -G ${GROUP} -s /bin/sh -u ${UID} ${USER}


ADD root /
RUN chown -R ${USER}:${GROUP} ${APP_HOME}


VOLUME ["${APP_HOME}/data"]

# Server RPC is used for communication between Consul clients and servers for internal
# request forwarding.
EXPOSE 8300

# Serf LAN and WAN (WAN is used only by Consul servers) are used for gossip between
# Consul agents. LAN is within the datacenter and WAN is between just the Consul
# servers in all datacenters.
EXPOSE 8301 8301/udp 8302 8302/udp

# HTTP and DNS (both TCP and UDP) are the primary interfaces that applications
# use to interact with Consul.
EXPOSE 8500 8600 8600/udp

CMD ["/init"]