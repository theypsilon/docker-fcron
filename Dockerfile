FROM ubuntu:14.04
ARG FCRON_VERSION=3.2.0
ARG FCRON_MIRROR=http://fcron.free.fr/archives
ENV TEMP_PKG="gcc libc6-dev make vim wget"
RUN DEBIAN_FRONTEND=noninteractive \
apt-get clean && apt-get update && \
apt-get install -y ${TEMP_PKG} && \
mkdir -p /tmp && cd /tmp && \
wget ${FCRON_MIRROR}/fcron-${FCRON_VERSION}.src.tar.gz && \
tar -xvf fcron-${FCRON_VERSION}.src.tar.gz && \
cd fcron-${FCRON_VERSION} && \
./configure --prefix=/usr          \
            --sysconfdir=/etc      \
            --localstatedir=/var   \
            --with-sendmail=no     \
            --with-boot-install=no \
            --with-systemdsystemunitdir=no \
            --with-editor=/usr/bin/vim \
            --with-pam=no \
            --with-selinux=no \
            --with-fcrondyn=no \
            && make && make install \
&& apt-get purge -y ${TEMP_PKG} \
&& apt-get clean autoclean && apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD fcrontab /fcron/fcrontab && fcron -f --nosyslog